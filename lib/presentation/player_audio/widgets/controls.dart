import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final PlayerState? playerState = snapshot.data;
          final ProcessingState? processingState = playerState?.processingState;
          final bool? playing = playerState?.playing;
          print(snapshot);
          if (!(playing ?? false)) {
            return IconButton(
              padding: EdgeInsets.zero,
              onPressed: audioPlayer.play,
              icon: Icon(
                Icons.play_circle,
                size: 50,
              ),
            );
          }else if(processingState != ProcessingState.completed){
            return IconButton(
              padding: EdgeInsets.zero,
              onPressed: audioPlayer.pause,
              icon: Icon(
                Icons.pause_circle,
                size: 50,
              ),
            );
          } else if(processingState == ProcessingState.completed){
            return IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){},
              icon: Icon(
                Icons.play_circle,
                size: 50,
              ),
            );
          }
          return const Icon(
            Icons.play_circle,
            size: 50,
          );
        });
  }
}
