import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:dropandgouser/application/audio_bloc/audio_bloc.dart';
import 'package:dropandgouser/application/audio_bloc/audio_cubit/download_progress_cubit.dart';
import 'package:dropandgouser/application/likes_bloc/likes_cubit.dart';
import 'package:dropandgouser/application/likes_bloc/likes_state.dart';
import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:dropandgouser/domain/player_audio/position_data.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/player_audio/widgets/controls.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/audio_progress_bar.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/widgets/standard_text.dart';

class PlayerAudioPage extends StatefulWidget {
  const PlayerAudioPage({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  final String categoryId;

  @override
  State<PlayerAudioPage> createState() => _PlayerAudioPageState();
}

class _PlayerAudioPageState extends State<PlayerAudioPage> {
  late AudioPlayer _audioPlayer;
  late final ConcatenatingAudioSource _playlist;
  final ReceivePort _port = ReceivePort();
  int progress = 0;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    context.read<AudioBloc>().add(
          FetchAudios(
            categoryId: widget.categoryId,
          ),
        );
    _audioPlayer = AudioPlayer();
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // setState(() {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      progress = data[2];
      print('Download $progress');
      context.read<DownloadProgressCubit>().updateDownloadProgress(progress);
      if (progress == 100) {
        context.read<DownloadProgressCubit>().reset();
      }
    });
    // });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? sendPort =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    sendPort!.send([id, status, progress]);
  }

  Future<void> download(String url) async {
    PermissionStatus storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
      download(url);
    }
    if (storageStatus.isGranted) {
      Directory? dir = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationDocumentsDirectory(); //FOR iOS
      if (dir != null) {
        String path = dir.path;
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          headers: {},
          // optional: header send with url (auth token etc)
          savedDir: path,
          showNotification: true,
          saveInPublicStorage: true,
          // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
        );
        print("Task id = $taskId");
      }
    }
  }

  _initAudioPlayer() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioBloc, AudioState>(
      listener: (context, state) {
        if (state is AudioStateLoaded) {
          final List<AudioSource> audioSources = <AudioSource>[];
          for (var data in state.audios) {
            if (data.audioUrl != null) {
              var audioSource = AudioSource.uri(
                Uri.parse(data.audioUrl!),
                tag: MediaItem(
                  id: data.id ?? Random().nextInt(100).toString(),
                  title: data.title ?? 'N/A',
                  artist: data.artist ?? 'N/A',
                ),
              );
              audioSources.add(audioSource);
            }
          }
          _playlist = ConcatenatingAudioSource(
            children: audioSources,
          );
          _initAudioPlayer();
        }
      },
      child: BlocBuilder<AudioBloc, AudioState>(builder: (context, state) {
        return (state is AudioStateLoading)
            ? const DropAndGoButtonLoading()
            : (state is AudioStateLoaded)
                ? Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(70),
                      child: AppBar(
                        title: state.category.name != null
                            ? StandardText.headline4(
                                context,
                                state.category.name!.toUpperCase(),
                                color: DropAndGoColors.black,
                              )
                            : StandardText.headline4(
                                context,
                                "Category",
                                color: DropAndGoColors.black,
                              ),
                        leading: IconButton(
                          icon: SvgPicture.asset(
                            DropAndGoIcons.arrowLeft,
                          ),
                          onPressed: () {
                            getIt<NavigationService>().navigateBack(
                              context: context,
                            );
                          },
                        ),
                      ),
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.h,
                      ),
                      child: Column(
                        children: [
                          HomeRectCategory(
                            categoryName: state.category.name,
                            height: 247.h,
                            imageUrl: state.category.imageUrl,
                          ),
                          34.verticalSpace,
                          Visibility(
                            visible: state.audios.isNotEmpty,
                            child: StreamBuilder<SequenceState?>(
                                stream: _audioPlayer.sequenceStateStream,
                                builder: (context,
                                    AsyncSnapshot<SequenceState?> snapshot) {
                                  final sequenceState = snapshot.data;
                                  if (sequenceState?.sequence.isEmpty ?? true) {
                                    return const SizedBox.shrink();
                                  }
                                  final metadata = sequenceState!
                                      .currentSource!.tag as MediaItem;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: StandardText.headline4(
                                              context,
                                              metadata.title,
                                              color: DropAndGoColors.primary,
                                              align: TextAlign.start,
                                              fontSize: 30,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons
                                                    .download_for_offline_outlined,
                                                size: 20,
                                              ),
                                              iconSize: 20,
                                              onPressed: () {
                                                List<Audio> tempAudios = state
                                                    .audios
                                                    .where((element) =>
                                                        element.title ==
                                                        metadata.title)
                                                    .toList();
                                                // print(tempAudios.first.audioUrl);
                                                if (tempAudios.first.audioUrl !=
                                                    null) {
                                                  String fileName = tempAudios
                                                      .first.title!
                                                      .replaceAll(' ', '');
                                                  download(
                                                      '${tempAudios.first.audioUrl!}?name=$fileName');
                                                  // download('${tempAudios.first.audioUrl!}?name=${tempAudios.first.title}');
                                                  print(
                                                      "${tempAudios.first.audioUrl!}?category=${tempAudios.first.category?.imageUrl}&name=$fileName");
                                                }
                                              },
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                if (state.category.id != null) {
                                                  context
                                                      .read<LikesCubit>()
                                                      .likeCategory(
                                                        categoryId:
                                                            state.category.id!,
                                                      );
                                                }
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (ctx) =>
                                                //       const SessionCompletePage(),
                                                // );
                                              },
                                              child: BlocBuilder<LikesCubit,
                                                      LikesState>(
                                                  builder:
                                                      (context, likeState) {
                                                final user =
                                                    getIt<UserService>()
                                                        .userData;
                                                return (likeState
                                                        is LikesStateLoading)
                                                    ? const SizedBox.shrink()
                                                    : (likeState
                                                            is LikesStateLoaded)
                                                        ? likeState.userData
                                                                        .likedCategories !=
                                                                    null &&
                                                                likeState
                                                                    .userData
                                                                    .likedCategories!
                                                                    .contains(state
                                                                        .category
                                                                        .id)
                                                            ? SvgPicture.asset(
                                                                DropAndGoIcons
                                                                    .favoriteFilled,
                                                              )
                                                            : SvgPicture.asset(
                                                                DropAndGoIcons
                                                                    .favoriteOutlined,
                                                              )
                                                        : user!.likedCategories !=
                                                                    null &&
                                                                user.likedCategories!
                                                                    .contains(state
                                                                        .category
                                                                        .id)
                                                            ? SvgPicture.asset(
                                                                DropAndGoIcons
                                                                    .favoriteFilled,
                                                              )
                                                            : SvgPicture.asset(
                                                                DropAndGoIcons
                                                                    .favoriteOutlined,
                                                              );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      StandardText.body2(
                                        context,
                                        metadata.artist ?? 'N/A',
                                      ),
                                      BlocBuilder<DownloadProgressCubit, int>(
                                          builder: (context, downloadProgress) {
                                        return Visibility(
                                          visible: downloadProgress > 0 &&
                                              downloadProgress < 100,
                                          child: LinearProgressIndicator(
                                            color: DropAndGoColors.primary,
                                            value: (downloadProgress / 100)
                                                .toDouble(),
                                          ),
                                        );
                                      }),
                                    ],
                                  );
                                }),
                          ),
                          Visibility(
                            visible: state.audios.isNotEmpty,
                            child: 100.verticalSpace,
                          ),
                          Visibility(
                            visible: state.audios.isNotEmpty,
                            child: StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionState = snapshot.data;
                                final progress =
                                    positionState?.position ?? Duration.zero;
                                final buffered =
                                    positionState?.bufferedPosition ??
                                        Duration.zero;
                                final total =
                                    positionState?.duration ?? Duration.zero;
                                return ProgressBar(
                                  progressBarColor: DropAndGoColors.primary,
                                  thumbColor: DropAndGoColors.primary,
                                  baseBarColor:
                                      DropAndGoColors.primary.withOpacity(.02),
                                  bufferedBarColor:
                                      DropAndGoColors.primary.withOpacity(.05),
                                  progress: progress,
                                  buffered: buffered,
                                  total: total,
                                  onSeek: (duration) {
                                    _audioPlayer.seek(duration);
                                  },
                                );
                              },
                            ),
                          ),
                          Visibility(
                              visible: state.audios.isNotEmpty,
                              child: 26.verticalSpace),
                          Visibility(
                            visible: state.audios.isNotEmpty,
                            child: Controls(
                              audioPlayer: _audioPlayer,
                            ),
                          ),
                          Visibility(
                            visible: state.audios.isEmpty,
                            child: Column(
                              children: [
                                100.verticalSpace,
                                StandardText.headline5(
                                  context,
                                  "No playlist added yet,\n Please try again later",
                                  maxLines: 2,
                                  align: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : (state is AudioStateError)
                    ? StandardText.headline4(
                        context,
                        state.message,
                      )
                    : const SizedBox.shrink();
      }),
    );
  }
}
