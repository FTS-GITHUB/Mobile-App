import 'dart:math';

import 'package:dropandgouser/domain/player_audio/position_data.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/player_audio/widgets/controls.dart';
import 'package:dropandgouser/presentation/session_complete/session_complete_page.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/audio_progress_bar.dart';
import 'package:flutter/material.dart';
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
  final List<double> values = [];
  final _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse(
            'https://cdn.pixabay.com/download/audio/2023/01/01/audio_816821e627.mp3'),
        tag: const MediaItem(
          id: '1',
          title: 'Through the veins',
          artist: 'Ema johns',
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            'https://cdn.pixabay.com/audio/2022/10/14/audio_9939f792cb.mp3'),
        tag: const MediaItem(
          id: '2',
          title: 'Relaxing',
          artist: 'Vicky',
        ),
      ),
    ],
  );

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
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
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
    values.clear();
    var rng = Random();
    for (var i = 0; i < 100; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: StandardText.headline4(
            context,
            'Anxiety'.toUpperCase(),
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
              categoryName: 'ANXIETY',
              height: 247.h,
              imageUrl: DropAndGoImages.addictions,
            ),
            34.verticalSpace,
            StreamBuilder<SequenceState?>(
                stream: _audioPlayer.sequenceStateStream,
                builder: (context, AsyncSnapshot<SequenceState?> snapshot) {
                  final state = snapshot.data;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  }
                  final metadata = state!.currentSource!.tag as MediaItem;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                showDialog(
                                  context: context,
                                  builder: (ctx) => const SessionCompletePage(),
                                );
                              },
                              child: SvgPicture.asset(
                                DropAndGoIcons.favoriteOutlined,
                              ),
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
            100.verticalSpace,
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionState = snapshot.data;
                final progress = positionState?.position ?? Duration.zero;
                final buffered =
                    positionState?.bufferedPosition ?? Duration.zero;
                final total = positionState?.duration ?? Duration.zero;
                return ProgressBar(
                  progressBarColor: DropAndGoColors.primary,
                  thumbColor: DropAndGoColors.primary,
                  baseBarColor: DropAndGoColors.primary.withOpacity(.02),
                  bufferedBarColor: DropAndGoColors.primary.withOpacity(.05),
                  progress: progress,
                  buffered: buffered,
                  total: total,
                  onSeek: (duration) {
                    _audioPlayer.seek(duration);
                  },
                );
              },
            ),
            26.verticalSpace,
            Controls(
              audioPlayer: _audioPlayer,
            ),
          ],
        ),
      ),
    );
  }
}
