import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/size_utils.dart'; // Import SizeUtils

class ListItemSkeleton extends StatefulWidget {
  final double? height;
  final double? avatarSize;
  final double? textPlaceholderWidth;
  final double? textPlaceholderHeight;
  final double? spacing;
  final EdgeInsetsGeometry? padding;

  const ListItemSkeleton({
    super.key,
    this.height = 122.0,
    this.avatarSize = 80.0,
    this.textPlaceholderWidth = 200.0,
    this.textPlaceholderHeight = 36.0,
    this.spacing = 20.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
  });

  @override
  State<ListItemSkeleton> createState() => _ListItemSkeletonState();
}

class _ListItemSkeletonState extends State<ListItemSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _gradientPosition = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Convert pixel values to dp using SizeUtils
    final double resolvedHeight = SizeUtils.pxToDp(context, widget.height);
    final double resolvedAvatarSize =
        SizeUtils.pxToDp(context, widget.avatarSize);
    final double resolvedTextPlaceholderWidth =
        SizeUtils.pxToDp(context, widget.textPlaceholderWidth);
    final double resolvedTextPlaceholderHeight =
        SizeUtils.pxToDp(context, widget.textPlaceholderHeight);
    final double resolvedSpacing = SizeUtils.pxToDp(context, widget.spacing);
    final double resolvedBorderRadius = SizeUtils.pxToDp(
        context, 4.0); // Assuming 4.0 was a pixel value for border radius

    EdgeInsetsGeometry resolvedPadding = widget.padding!;
    if (widget.padding is EdgeInsets) {
      final EdgeInsets padding = widget.padding as EdgeInsets;
      resolvedPadding = EdgeInsets.only(
        left: SizeUtils.pxToDp(context, padding.left),
        right: SizeUtils.pxToDp(context, padding.right),
        top: SizeUtils.pxToDp(context, padding.top),
        bottom: SizeUtils.pxToDp(context, padding.bottom),
      );
    } else if (widget.padding is EdgeInsetsDirectional) {
      final EdgeInsetsDirectional padding =
          widget.padding as EdgeInsetsDirectional;
      resolvedPadding = EdgeInsetsDirectional.only(
        start: SizeUtils.pxToDp(context, padding.start),
        end: SizeUtils.pxToDp(context, padding.end),
        top: SizeUtils.pxToDp(context, padding.top),
        bottom: SizeUtils.pxToDp(context, padding.bottom),
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment(_gradientPosition.value, 0.0),
          end: Alignment(_gradientPosition.value + 1,
              0.0), // Adjust based on the desired shimmer width
          colors: const [
            Color(0xFFE0E0E0), // Light grey
            Color(0xFFF5F5F5), // Lighter grey (highlight)
            Color(0xFFE0E0E0), // Light grey
          ],
          stops: const [0.0, 0.5, 1.0], // Shimmer effect
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      blendMode: BlendMode
          .srcATop, // This blend mode works well for shimmer on placeholders
      child: Container(
        height: resolvedHeight, // Use resolvedHeight
        padding: resolvedPadding, // Use resolvedPadding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: resolvedAvatarSize, // Use resolvedAvatarSize
              height: resolvedAvatarSize, // Use resolvedAvatarSize
              decoration: const BoxDecoration(
                color: Colors.white, // Placeholder color for shimmer base
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: resolvedSpacing), // Use resolvedSpacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width:
                      resolvedTextPlaceholderWidth, // Use resolvedTextPlaceholderWidth
                  height:
                      resolvedTextPlaceholderHeight, // Use resolvedTextPlaceholderHeight
                  decoration: BoxDecoration(
                    color: Colors.white, // Placeholder color for shimmer base
                    borderRadius: BorderRadius.circular(
                        resolvedBorderRadius), // Use resolvedBorderRadius
                  ),
                ),
                // You can add more placeholder lines if needed
                // SizedBox(height: 8.0),
                // Container(
                //   width: widget.textPlaceholderWidth * 0.7,
                //   height: widget.textPlaceholderHeight,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(4.0),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
