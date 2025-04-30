import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class ScreenshotCard extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  const ScreenshotCard({
    Key? key,
    required this.imageUrl,
    this.width = 300,
    this.height = 180,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onTap,
  }) : super(key: key);

  @override
  State<ScreenshotCard> createState() => _ScreenshotCardState();
}

class _ScreenshotCardState extends State<ScreenshotCard> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Focus(
        focusNode: _focusNode,
        child: RemoteControlWrapper(
          onTap: widget.onTap,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: _focusNode.hasFocus
                    ? Theme.of(context)
                        .extension<AppTheme>()!
                        .get('primary')
                        .withOpacity(0.5)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Theme.of(context)
                          .extension<AppTheme>()!
                          .get('cardBg'),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Theme.of(context)
                              .extension<AppTheme>()!
                              .get('text'),
                        ),
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Theme.of(context)
                            .extension<AppTheme>()!
                            .get('cardBg'),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .extension<AppTheme>()!
                                .get('primary'),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),

                  // Gradient overlay (only shown when not focused)
                  if (!_focusNode.hasFocus)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .extension<AppTheme>()!
                                .get('overlay')
                                .withOpacity(0.1),
                            Theme.of(context)
                                .extension<AppTheme>()!
                                .get('overlay')
                                .withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
