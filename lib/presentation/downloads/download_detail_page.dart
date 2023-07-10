import 'dart:math';
import 'dart:ui';

import 'package:dropandgouser/domain/player_audio/audio.dart';
import 'package:dropandgouser/domain/player_audio/position_data.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/player_audio/widgets/controls.dart';
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

class DownloadDetailPage extends StatefulWidget {
  const DownloadDetailPage({
    Key? key,
    required this.audio,
  }) : super(key: key);

  final Audio audio;

  @override
  State<DownloadDetailPage> createState() => _DownloadDetailPageState();
}

class _DownloadDetailPageState extends State<DownloadDetailPage> {
  late AudioPlayer _audioPlayer;

  // late final ConcatenatingAudioSource _playlist;
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
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
    super.initState();
  }

  _initAudioPlayer() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    _audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          widget.audio.audioUrl ?? '',
        ),
        tag: MediaItem(
          id: widget.audio.id ?? Random().nextInt(100).toString(),
          title: widget.audio.title ?? 'N/A',
          artist: widget.audio.artist ?? 'N/A',
          displayTitle: widget.audio.imageUrl,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: StandardText.headline4(
            context,
            "Downloads",
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
            StreamBuilder<SequenceState?>(
                stream: _audioPlayer.sequenceStateStream,
                builder: (context, AsyncSnapshot<SequenceState?> snapshot) {
                  final sequenceState = snapshot.data;
                  if (sequenceState?.sequence.isEmpty ?? true) {
                    return const SizedBox.shrink();
                  }
                  final metadata =
                      sequenceState!.currentSource!.tag as MediaItem;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: DropAndGoColors.black),
                        height: 247.h,
                        width: double.infinity,
                        child: Icon(
                          Icons.music_note_outlined,
                          color: DropAndGoColors.white,
                          size: 50.h,
                        ),
                      ),
                      34.verticalSpace,
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
              isDownloadPage: true,
            ),
          ],
        ),
      ),
    );
  }
}
