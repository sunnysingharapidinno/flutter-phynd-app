import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class GameTrialsCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final String? trialDuration;
  final String? price;
  final String? coinPrice;
  final List<String>? friendAvatars;
  final int? friendsPlayingCount;
  final int? onlineCount;
  final List<PlatformIcon>? platforms;
  final List<ControllerIcon>? controllers;
  final VoidCallback? onTap;
  final String? esrbRating;
  final bool initiallyFocused;

  const GameTrialsCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.rating = 0,
    this.trialDuration,
    this.price,
    this.coinPrice,
    this.friendAvatars,
    this.friendsPlayingCount,
    this.onlineCount,
    this.platforms,
    this.controllers,
    this.onTap,
    this.esrbRating,
    this.initiallyFocused = false,
  }) : super(key: key);

  @override
  State<GameTrialsCard> createState() => _GameTrialsCardState();
}

class _GameTrialsCardState extends State<GameTrialsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  final FocusNode _focusNode = FocusNode();
  bool _isHovered = false;
  bool _isFocused = false;

  final double _normalWidth = 247.0;
  final double _expandedWidth = 505.0;
  final double _height = 314.0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != _isFocused) {
        _toggleFocus();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _widthAnimation = Tween<double>(
      begin: _normalWidth,
      end: _expandedWidth,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    ));

    if (widget.initiallyFocused) {
      _isFocused = true;
      _animationController.value = 1.0;
      Future.microtask(() {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFocus() {
    setState(() {
      _isFocused = !_isFocused;
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    // Remove the onTap call from here since it's now handled in the GestureDetector
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    // Default values for platforms if none provided
    final defaultPlatforms = [
      PlatformIcon.windows,
      PlatformIcon.mobile,
      PlatformIcon.cloud,
    ];

    // Default values for controllers if none provided
    final defaultControllers = [
      ControllerIcon.gamepad,
      ControllerIcon.touchscreen,
      ControllerIcon.keyboard,
    ];

    final platforms = widget.platforms ?? defaultPlatforms;
    final controllers = widget.controllers ?? defaultControllers;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        child: Focus(
          focusNode: _focusNode,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return RemoteControlWrapper(
                onEnter: widget.onTap,
                onTap: () {
                  FocusScope.of(context).requestFocus(_focusNode);
                  if (widget.onTap != null) {
                    widget.onTap!(); // Execute the onTap callback
                  }
                },
                child: Container(
                  width: _widthAnimation.value,
                  height: _height,
                  decoration: BoxDecoration(
                    color: theme.get('trialCardBg'),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _focusNode.hasFocus || _isHovered
                          ? theme.get('primary').withOpacity(0.5)
                          : theme.get('trialCardBorder'),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      children: [
                        // Background image
                        Positioned.fill(
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: theme.get('trialCardHighlight'),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: theme.get('trialCardBorder'),
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                        ),

                        if (_focusNode.hasFocus) ...[
                          // Expanded state content
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    theme.get('cardOverlay'),
                                  ],
                                ),
                              ),
                              child: _buildExpandedContent(
                                  theme, platforms, controllers),
                            ),
                          ),
                        ] else ...[
                          // Normal state content
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            width: _normalWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Game Image and Badge
                                Expanded(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      if (widget.trialDuration != null)
                                        Positioned(
                                          top: 12,
                                          left: 12,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: theme.get('trialBadge'),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              'Free ${widget.trialDuration}hr Trial',
                                              style: TextStyle(
                                                color:
                                                    theme.get('trialBadgeText'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                // Bottom bar with coin info
                                if (widget.coinPrice != null)
                                  Container(
                                    height: 48,
                                    color: theme.get('trialCardBg'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          color: theme.get('trialPrice'),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Play to Earn ${widget.coinPrice}',
                                          style: TextStyle(
                                            color: theme.get('text'),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.token,
                                          color: theme.get('trialCoin'),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent(AppTheme theme, List<PlatformIcon> platforms,
      List<ControllerIcon> controllers) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section with platforms and controllers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Trial badge
              if (widget.trialDuration != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.get('trialBadge'),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Free ${widget.trialDuration}hr Trial',
                    style: TextStyle(
                      color: theme.get('trialBadgeText'),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // Platform and controller icons
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Platforms
                            ...platforms.map((platform) => Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      platform.icon,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 8),
                            // Controllers
                            ...controllers.map((controller) => Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      controller.icon,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          // Bottom section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating stars
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      index < widget.rating
                          ? Icons.star
                          : index < widget.rating + 0.5
                              ? Icons.star_half
                              : Icons.star_border,
                      color: Colors.amber,
                      size: 24,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              // Price section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (widget.price != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.get('trialPrice'),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: theme.get('trialBadgeText'),
                              size: 18,
                            ),
                            Text(
                              widget.price!,
                              style: TextStyle(
                                color: theme.get('trialBadgeText'),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (widget.price != null && widget.coinPrice != null) ...[
                      const SizedBox(width: 12),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: theme.get('trialBadgeText').withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (widget.coinPrice != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.get('trialCoin'),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: theme.get('trialBadgeText'),
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.coinPrice} PHYND Coins',
                              style: TextStyle(
                                color: theme.get('trialBadgeText'),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Friends section
              if (widget.friendsPlayingCount != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (widget.friendAvatars != null &&
                          widget.friendAvatars!.isNotEmpty)
                        _buildFriendAvatars(
                          widget.friendAvatars!,
                          widget.friendsPlayingCount ?? 0,
                        ),
                      const SizedBox(width: 12),
                      Text(
                        '${widget.friendsPlayingCount} Friends Play this Game',
                        style: TextStyle(
                          color: theme.get('trialFriends'),
                          fontSize: 14,
                        ),
                      ),
                      if (widget.onlineCount != null) ...[
                        const SizedBox(width: 16),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.get('trialPrice'),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.onlineCount} Online',
                          style: TextStyle(
                            color: theme.get('trialFriends'),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconCircle(AppTheme theme, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.get('trialCardHighlight'),
          border: Border.all(
            color: theme.get('trialCardBorder'),
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: theme.get('text'),
          ),
        ),
      ),
    );
  }

  Widget _buildFriendAvatars(List<String> avatars, int totalCount) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return Container(
      width: 120, // Fixed width to prevent infinite constraints
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...List.generate(
            avatars.length > 4 ? 4 : avatars.length,
            (index) => Positioned(
              left: (index * 16).toDouble(),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.get('trialAvatarBorder'),
                    width: 1.5,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(avatars[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Additional friends indicator
          if (totalCount > 4)
            Positioned(
              left: 64, // Position after 4 avatars
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.get('trialAvatarOverlay'),
                  border: Border.all(
                    color: theme.get('trialAvatarBorder'),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+${totalCount - 4}',
                    style: TextStyle(
                      color: theme.get('trialAvatarText'),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PlatformIcon {
  final IconData icon;
  final String name;

  const PlatformIcon({
    required this.icon,
    required this.name,
  });

  static const windows = PlatformIcon(
    icon: Icons.desktop_windows,
    name: 'Windows',
  );

  static const mobile = PlatformIcon(
    icon: Icons.phone_android,
    name: 'Mobile',
  );

  static const cloud = PlatformIcon(
    icon: Icons.cloud,
    name: 'Cloud',
  );
}

class ControllerIcon {
  final IconData icon;
  final String name;

  const ControllerIcon({
    required this.icon,
    required this.name,
  });

  static const gamepad = ControllerIcon(
    icon: Icons.gamepad,
    name: 'Gamepad',
  );

  static const touchscreen = ControllerIcon(
    icon: Icons.touch_app,
    name: 'Touchscreen',
  );

  static const keyboard = ControllerIcon(
    icon: Icons.keyboard,
    name: 'Keyboard',
  );
}
