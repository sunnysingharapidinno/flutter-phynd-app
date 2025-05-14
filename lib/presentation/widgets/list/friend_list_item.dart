import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class FriendListItem extends StatefulWidget {
  final String gamerTag;
  final bool isRequest;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final bool? isGame;

  const FriendListItem({
    super.key,
    required this.gamerTag,
    this.isRequest = false,
    this.onAccept,
    this.onDecline,
    this.isGame = false,
  });

  @override
  State<FriendListItem> createState() => _FriendListItemState();
}

class _FriendListItemState extends State<FriendListItem>
    with SingleTickerProviderStateMixin {
  bool _requestOptionOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRequestOptions() {
    if (widget.isRequest && widget.isGame == false) {
      setState(() {
        _requestOptionOpen = !_requestOptionOpen;
        if (_requestOptionOpen) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final cardColor = theme?.get('borderColors');
    final bgColor = theme?.get('bgColor');
    final activeTabColor = theme?.get('subText2');

    final double horizontalPadding = SizeUtils.pxToDp(context, 40);
    final double verticalPadding = SizeUtils.pxToDp(context, 16);

    return RemoteControlWrapper(
      onTap: _toggleRequestOptions,
      child: Container(
        color: cardColor,
        padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
            horizontalPadding, verticalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (widget.isGame ?? false)
                    ? ImageThumbnail(
                        imageUrl:
                            'https://xstrela-dev.s3.amazonaws.com/launchpadDisplayImages/images/117145585264201714558527519.png',
                        height: 100,
                        width: 157,
                        fit: BoxFit.cover,
                        borderRadius: 6,
                      )
                    : ImageThumbnail(
                        imageUrl: AppImages.profileAvatarRed,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                        borderRadius: 200,
                        isNetwork: false,
                      ),
                SizedBox(width: SizeUtils.pxToDp(context, 20)),
                Expanded(
                  child: Text(
                    widget.gamerTag,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: FontUtils.pxToSp(context, 32),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1.0,
              child: FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: EdgeInsets.only(top: SizeUtils.pxToDp(context, 20)),
                  child: widget.isRequest && widget.isGame == false
                      ? Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                text: 'Accept',
                                height: 54,
                                fontSize: 28,
                                textColor: bgColor,
                                backgroundColor: activeTabColor,
                                onPressed: widget.onAccept,
                              ),
                            ),
                            SizedBox(width: SizeUtils.pxToDp(context, 16)),
                            Expanded(
                              child: PrimaryButton(
                                text: 'Deny',
                                height: 54,
                                fontSize: 28,
                                textColor: bgColor,
                                backgroundColor: activeTabColor,
                                onPressed: widget.onDecline,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
