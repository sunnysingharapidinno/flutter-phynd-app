import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:video_player/video_player.dart';

class ImageVideo extends StatefulWidget {
  final String? imageUrl;
  final String? videoUrl;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;

  const ImageVideo({
    super.key,
    required this.imageUrl,
    required this.videoUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  });

  @override
  State<ImageVideo> createState() => _ImageVideoState();
}

class _ImageVideoState extends State<ImageVideo> {
  late VideoPlayerController _videoController;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl ?? '')
      ..setLooping(true)
      ..initialize().then((_) {
        if (mounted) setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _onFocusChanged(bool focused) {
    setState(() {
      _isFocused = focused;
      if (_isFocused) {
        _videoController.play();
      } else {
        _videoController.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onFocusChanged(true),
      onTapUp: (_) => _onFocusChanged(false),
      onTapCancel: () => _onFocusChanged(false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            SizeUtils.pxToDp(context, widget.borderRadius ?? 0)),
        child: SizedBox(
          width: SizeUtils.pxToDp(context, widget.width ?? 100),
          height: SizeUtils.pxToDp(context, widget.height ?? 100),
          child: Stack(
            children: [
              ImageThumbnail(
                imageUrl: widget.imageUrl,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
              ),
              if (_videoController.value.isInitialized && _isFocused)
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
