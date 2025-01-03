import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  PageController controller = PageController(keepPage: true);
  List<String> listOfVideos = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  ];

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (value) {
          print("Current page : $value");
        },
        controller: controller,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(parent: BouncingScrollPhysics()),
        itemBuilder: (BuildContext context, int index) {
          return MyVideoPlayerItem(videoUrl: listOfVideos[index]);
        },
        itemCount: listOfVideos.length,
      ),
    );
  }
}

class MyVideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const MyVideoPlayerItem({required this.videoUrl, super.key});

  @override
  State<MyVideoPlayerItem> createState() => _MyVideoPlayerItemState();
}

class _MyVideoPlayerItemState extends State<MyVideoPlayerItem> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize()
          ..setLooping(true).then(
            (value) {
              setState(() {});
            },
          );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (VisibilityInfo visibilityInfo) {
        var visibilityPercentage = visibilityInfo.visibleFraction * 100;
        if (visibilityPercentage >= 100) {
          _videoPlayerController.play();
        }
      },
      child: GestureDetector(
        onTap: () async {
          if (_videoPlayerController.value.isPlaying) {
            await _videoPlayerController.pause();
          } else {
            await _videoPlayerController.play();
          }
        },
        child: VideoPlayer(_videoPlayerController),
      ),
    );
  }
}
