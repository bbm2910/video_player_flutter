import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  String videoUrl = 'https://www.w3schools.com/html/mov_bbb.mp4';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await _videoPlayerController.initialize();

    if (!mounted) return;

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: const CustomVideoPlayerSettings(
        // Play/Pause control
        settingsButtonAvailable: true,
        playbackSpeedButtonAvailable: true,
        showSeekButtons: true,
        // Control bar
        controlBarPadding: EdgeInsets.all(8),
        // Control bar style
        controlBarDecoration: BoxDecoration(
          color: Colors.black26,
        ),
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _videoPlayerController.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    if (_videoPlayerController.value.isPlaying) {
                      _videoPlayerController.pause();
                    } else {
                      _videoPlayerController.play();
                    }
                  },
                  child: CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController,
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
