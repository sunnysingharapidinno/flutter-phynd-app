import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomVideoPlayer();
  }
}
