import 'dart:math';

import 'package:dropandgouser/application/audio_bloc/audio_bloc.dart';
import 'package:dropandgouser/application/likes_bloc/likes_cubit.dart';
import 'package:dropandgouser/application/likes_bloc/likes_state.dart';
import 'package:dropandgouser/domain/player_audio/position_data.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/player_audio/widgets/controls.dart';
import 'package:dropandgouser/presentation/session_complete/session_complete_page.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/audio_progress_bar.dart';
import 'package:dropandgouser/shared/widgets/button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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
    // _initAudioPlayer();
    // ..setUrl(
    //     'https://cdn.pixabay.com/download/audio/2023/01/01/audio_816821e627.mp3?filename=relaxed-vlog-night-street-131746.mp3');
    // ..setUrl('https://cdn.pixabay.com/audio/2022/10/14/audio_9939f792cb.mp3');
    // _audioPlayer = AudioPlayer()..setAsset('assets/audio/relaxing.mp3');
    super.initState();
  }

  _initAudioPlayer() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: IconButton(
                                          //     icon: SvgPicture.asset(
                                          //       DropAndGoIcons.shareFill,
                                          //       color: DropAndGoColors.primary,
                                          //       width: 30,
                                          //         height: 30,
                                          //     ),
                                          //       iconSize: 30,
                                          //     onPressed: (){
                                          //       showModalBottomSheet(context: context, builder: (ctx)=>
                                          //       Container(
                                          //         height: context.height*.3,
                                          //         color: DropAndGoColors.yellow,
                                          //       )
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                          // 8.horizontalSpace,
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
                                                  builder: (context, likeState) {
                                                return (likeState
                                                        is LikesStateLoading)
                                                    ? const SizedBox.shrink()
                                                    : (likeState
                                                            is LikesStateLoaded)
                                                        ? likeState.userData
                                                    .likedCategories !=
                                                    null &&
                                                    likeState.userData
                                                        .likedCategories!
                                                        .contains(state.category.id)
                                                    ? SvgPicture.asset(
                                                  DropAndGoIcons
                                                      .favoriteFilled,
                                                )
                                                        : SvgPicture.asset(
                                                            DropAndGoIcons
                                                                .favoriteOutlined,
                                                          ):SvgPicture.asset(
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
