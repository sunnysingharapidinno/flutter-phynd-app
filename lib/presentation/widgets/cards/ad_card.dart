import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class AdCard extends StatefulWidget {
  final String? brandName;
  final String? description;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final VoidCallback? onWatchTap;
  final VoidCallback? onShopTap;

  const AdCard({
    Key? key,
    this.brandName = 'Brand/Publisher Name',
    this.description = 'This is where a line of copy will render',
    this.width = 280,
    this.height = 160,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onWatchTap,
    this.onShopTap,
  }) : super(key: key);

  @override
  State<AdCard> createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return RemoteControlWrapper(
      onEnter: widget.onWatchTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: theme.get('cardBg'),
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Your Ad Here text
                  Expanded(
                    child: Center(
                      child: Text(
                        'Your Ad Here',
                        style: TextStyle(
                          color: theme.get('text'),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Sponsored label
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.get('cardBg').withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: theme.get('text').withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      'Sponsored',
                      style: TextStyle(
                        color: theme.get('text'),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Brand/Publisher name with dot
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.get('primary'),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.brandName ?? '',
                        style: TextStyle(
                          color: theme.get('text'),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        size: 12,
                        color: theme.get('primary'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Description
                  Text(
                    widget.description ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.get('text').withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Watch Ad button
                      RemoteControlWrapper(
                        onEnter: widget.onWatchTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.get('primary'),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Watch Ad',
                            style: TextStyle(
                              color: theme.get('textOnPrimary'),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Shop Now button
                      RemoteControlWrapper(
                        onEnter: widget.onShopTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.get('accent'),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              color: theme.get('text'),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
