import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:whatsapp/core/constants/colors.dart';

class DisplayVideoItem extends StatefulWidget {
  final String videoUrl;
  const DisplayVideoItem({super.key, required this.videoUrl});

  @override
  State<DisplayVideoItem> createState() => _DisplayVideoItemState();
}

class _DisplayVideoItemState extends State<DisplayVideoItem> {
  late CachedVideoPlayerController videoController;
  bool isPlaying = false;

  @override
  void initState() {
    videoController = CachedVideoPlayerController.network(widget.videoUrl);
    videoController.initialize().then((value) {
      videoController.pause();
      videoController.setVolume(0.5);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(videoController),
          Center(
            child: IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 24,
                color: AppColor.textColor.withOpacity(0.5),
              ),
              onPressed: () {
                isPlaying ? videoController.pause() : videoController.play();
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
