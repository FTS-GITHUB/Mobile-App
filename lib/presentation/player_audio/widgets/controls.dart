import 'package:dropandgouser/shared/constants/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({
    Key? key,
    required this.audioPlayer,
    this.isDownloadPage = false,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final bool isDownloadPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (!isDownloadPage)
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: audioPlayer.seekToPrevious,
            icon: SvgPicture.asset(
              DropAndGoIcons.previous,
            ),
            iconSize: 24,
          ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final PlayerState? playerState = snapshot.data;
            final ProcessingState? processingState =
                playerState?.processingState;
            final bool? playing = playerState?.playing;
            if (kDebugMode) {
              print(snapshot);
            }
            if (!(playing ?? false)) {
              return IconButton(
                padding: EdgeInsets.zero,
                onPressed: audioPlayer.play,
                icon: SvgPicture.asset(
                  DropAndGoIcons.playCircle,
                ),
                iconSize: 75,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                padding: EdgeInsets.zero,
                onPressed: audioPlayer.pause,
                icon: SvgPicture.asset(
                  DropAndGoIcons.pauseCircle,
                  width: 75,
                  height: 75,
                ),
                iconSize: 75,
              );
            } else if (processingState == ProcessingState.completed) {
              return IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: SvgPicture.asset(
                  DropAndGoIcons.playCircle,
                ),
                iconSize: 75,
              );
            }
            return SvgPicture.asset(
              DropAndGoIcons.playCircle,
              width: 75,
              height: 75,
            );
          },
        ),
        if (!isDownloadPage)
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: audioPlayer.seekToNext,
            icon: SvgPicture.asset(
              DropAndGoIcons.next,
            ),
            iconSize: 24,
          ),
      ],
    );
  }
}
