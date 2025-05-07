import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
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
    final textColor = theme?.get('text') ?? Colors.black;
    final backgroundColor = theme?.get('bgColor') ?? Colors.black;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: SizeUtils.pxToDp(context, 165),
      color: backgroundColor,
      child: Padding(
        padding: SizeUtils.pxToEdgeInsets(context,
            left: 120, right: 120, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Brand logo
            _buildBrandLogo(),

            // Center: Search bar
            SizedBox(
              width: screenWidth * 0.5,
              child: SearchInputField(
                hintText: 'Phynd Anything...',
              ),
            ),

            // Right: Profile info
            _buildProfileInfo(textColor, context),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandLogo() {
    return Row(
      children: [
        Image.asset(
          'assets/images/phynd_logo.png',
          height: 40,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Text(
                    'PHYND',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'ALPHA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfileInfo(Color textColor, BuildContext context) {
    return Row(
      children: [
        // Username and online status
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AutoSizeText(
              username ?? 'GamerTag1234',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: FontUtils.pxToSp(context, 28),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 12),
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[800],
            image: avatarUrl != null
                ? DecorationImage(
                    image: NetworkImage(avatarUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: avatarUrl == null
              ? const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                )
              : null,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(165);
}
