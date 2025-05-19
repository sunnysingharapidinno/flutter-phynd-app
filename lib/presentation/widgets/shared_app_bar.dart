import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_state.dart';
import 'package:phynd_app/presentation/widgets/input_fields/search_input_field.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final String? username;
  final bool isOnline;
  final String? avatarUrl;

  const SharedAppBar({
    super.key,
    this.onMenuPressed,
    this.username,
    this.isOnline = true,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text');
    final backgroundColor = theme?.get('bgColor');

    return Container(
      height: SizeUtils.pxToDp(context, 165),
      color: backgroundColor,
      child: Padding(
        padding: SizeUtils.pxToEdgeInsets(context,
            left: 120, right: 120, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Brand logo
            _buildBrandLogo(context),
            SizedBox(width: SizeUtils.pxToDp(context, 40)),
            // Center: Search bar
            Expanded(
              child: Center(
                child: Container(
                  height: SizeUtils.pxToDp(context, 80),
                  constraints: BoxConstraints(
                    maxWidth: SizeUtils.pxToDp(context, 1600),
                  ),
                  child: const SearchInputField(
                    hintText: 'Phynd Anything...',
                  ),
                ),
              ),
            ),

            SizedBox(width: SizeUtils.pxToDp(context, 40)),

            // Right: Profile info
            _buildProfileInfo(textColor!, context),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandLogo(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final border = theme?.get('borderColors');
    final tagBg = theme?.get('textSecondary');
    final text = theme?.get('bgColor');
    final textColor = theme?.get('text');

    Widget getVersion() {
      return Container(
        height: SizeUtils.pxToDp(context, 53),
        padding: SizeUtils.pxToEdgeInsets(context,
            left: 14, right: 14, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: tagBg,
          borderRadius: SizeUtils.pxToAllBorderRadius(context, radius: 4),
          border:
              Border.all(color: border!, width: SizeUtils.pxToDp(context, 2)),
        ),
        child: Center(
          child: Text(
            'ALPHA',
            style: TextStyle(
              color: text,
              fontWeight: FontWeight.w600,
              fontSize: FontUtils.pxToSp(context, 29),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Image.asset(
          AppImages.navLogo,
          height: SizeUtils.pxToDp(context, 75),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: SizeUtils.pxToDp(context, 32),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Text(
                    'PHYND',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontUtils.pxToSp(context, 18),
                    ),
                  ),
                  SizedBox(width: SizeUtils.pxToDp(context, 8)),
                  getVersion(),
                ],
              ),
            );
          },
        ),
        SizedBox(width: SizeUtils.pxToDp(context, 8)),
        getVersion()
      ],
    );
  }

  Widget _buildProfileInfo(Color textColor, BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Row(
          children: [
            Padding(
              padding: SizeUtils.pxToEdgeInsets(context,
                  left: 48, right: 48, top: 24, bottom: 24),
              child: Row(
                children: [
                  Image.asset(AppImages.profileAvatar,
                      fit: BoxFit.contain,
                      height: SizeUtils.pxToDp(context, 80),
                      width: SizeUtils.pxToDp(context, 80)),
                  SizedBox(width: SizeUtils.pxToDp(context, 32)),

                  Text(
                    authState.profile?.user.display_name ?? "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: FontUtils.pxToSp(context, 28),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(width: SizeUtils.pxToDp(context, 32)),

                  // status
                  Row(
                    children: [
                      Container(
                        width: SizeUtils.pxToDp(context, 16),
                        height: SizeUtils.pxToDp(context, 16),
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: SizeUtils.pxToDp(context, 8)),
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: FontUtils.pxToSp(context, 22),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: SizeUtils.pxToDp(context, 32)),
            Image.asset(AppImages.kidsLogo,
                fit: BoxFit.contain,
                height: SizeUtils.pxToDp(context, 80),
                width: SizeUtils.pxToDp(context, 80)),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(165);
}
