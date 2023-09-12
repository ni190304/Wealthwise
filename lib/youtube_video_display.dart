import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class YourVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  YourVideoPlayerWidget({required this.videoUrl});

  @override
  _YourVideoPlayerWidgetState createState() => _YourVideoPlayerWidgetState();
}

class _YourVideoPlayerWidgetState extends State<YourVideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          // Ensure the first frame is shown
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(), // You can show a loading indicator while the video is loading.
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
