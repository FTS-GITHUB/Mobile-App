import 'package:dropandgouser/domain/player_audio/position_data.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:dropandgouser/infrastructure/services/navigation_service.dart';
import 'package:dropandgouser/presentation/home/widgets/home_rect_category.dart';
import 'package:dropandgouser/presentation/player_audio/widgets/controls.dart';
import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:dropandgouser/shared/extensions/media_query.dart';
import 'package:dropandgouser/shared/helpers/colors.dart';
import 'package:dropandgouser/shared/packages/audio_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../shared/widgets/standard_text.dart';
import 'dart:math';
import 'package:audio_progress_bars/audio_progress_bars.dart';

class PlayerAudioPage extends StatefulWidget {
  const PlayerAudioPage({
    Key? key,
    required this.playerId,
  }) : super(key: key);

  final String playerId;

  @override
  State<PlayerAudioPage> createState() => _PlayerAudioPageState();
}

class _PlayerAudioPageState extends State<PlayerAudioPage> {
  late AudioPlayer _audioPlayer;
  final List<double> values = [];

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
    _audioPlayer = AudioPlayer()..setUrl('https://cdn.pixabay.com/audio/2022/10/14/audio_9939f792cb.mp3');
    // _audioPlayer = AudioPlayer()..setAsset('assets/audio/relaxing.mp3');
    super.initState();
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
            Expanded(
              child: StandardText.headline4(
                context,
                'Through the veins',
                color: DropAndGoColors.primary,
                align: TextAlign.start,
                fontSize: 30,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            100.verticalSpace,
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionState = snapshot.data;
                final progress = positionState?.position?? Duration.zero;
                final buffered = positionState?.bufferedPosition?? Duration.zero;
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
            // 26.verticalSpace,
            Controls(
              audioPlayer: _audioPlayer,
            ),
          ],
        ),
      ),
    );
  }
}
