import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class PrimaryIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color? iconColor;
  final double? iconSize;
  final double? radius;
  final double? loaderSize;
  final IconData icon;
  final bool? isLoading;

  const PrimaryIconButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    this.radius,
    required this.icon,
    this.iconSize,
    this.iconColor,
    this.isLoading,
    this.loaderSize,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final theme = appTheme.extension<AppTheme>();
    final textColor = theme?.get('text');
    final buttonBg2 = theme?.get('buttonBg2');

    return RemoteControlWrapper(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: buttonBg2 ?? buttonColor,
        radius: SizeUtils.pxToDp(context, radius ?? 36),
        child: isLoading == true
            ? SizedBox(
                width: SizeUtils.pxToDp(context, loaderSize ?? 24),
                height: SizeUtils.pxToDp(context, loaderSize ?? 24),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor!),
                ),
              )
            : IconButton(
                icon: Icon(
                  icon,
                  color: iconColor ?? textColor,
                ),
                iconSize: SizeUtils.pxToDp(context, iconSize ?? 43),
                onPressed: onPressed,
              ),
      ),
    );
  }
}
