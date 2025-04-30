import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class TournamentCard extends StatefulWidget {
  final String imageUrl;
  final String tournamentTitle;
  final List<String> sponsorNames;
  final int daysRemaining;
  final int hoursRemaining;
  final int minutesRemaining;
  final int friendsJoined;
  final List<String> friendAvatars;
  final VoidCallback? onRegisterTap;
  final VoidCallback? onBookmarkTap;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const TournamentCard({
    Key? key,
    required this.imageUrl,
    this.tournamentTitle = 'TOURNAMENT',
    this.sponsorNames = const ['METALCORE', 'OWNED', 'gamescom'],
    this.daysRemaining = 4,
    this.hoursRemaining = 11,
    this.minutesRemaining = 37,
    this.friendsJoined = 34,
    this.friendAvatars = const [],
    this.onRegisterTap,
    this.onBookmarkTap,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  @override
  State<TournamentCard> createState() => _TournamentCardState();
}

class _TournamentCardState extends State<TournamentCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return RemoteControlWrapper(
      onEnter: widget.onRegisterTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        constraints: BoxConstraints(
          maxWidth: widget.width ?? 350,
          minWidth: 280,
          maxHeight: widget.height ?? 200,
          minHeight: 180,
        ),
        // margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: theme.get('cardBg'),
                  child: Icon(
                    Icons.image_not_supported,
                    color: theme.get('text'),
                  ),
                ),
              ),

              // Dark gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sponsors row - horizontal scrollable ListView
                    SizedBox(
                      height: 16,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: widget.sponsorNames
                            .map((sponsor) => Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text(
                                    sponsor,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),

                    // Tournament title with overflow handling
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        widget.tournamentTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const Spacer(),

                    // Time remaining - compact layout
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time Remaining to Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${widget.daysRemaining}d ${widget.hoursRemaining}h ${widget.minutesRemaining}m',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Bottom row with friends joined and register button
                    LayoutBuilder(builder: (context, constraints) {
                      final availableWidth = constraints.maxWidth;
                      // Allocate space proportionally
                      final friendsWidth = availableWidth * 0.45;
                      final buttonsWidth = availableWidth * 0.55;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Friends joined - with constrained width
                          SizedBox(
                            width: friendsWidth,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '${widget.friendsJoined} Friends',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Register button and bookmark
                          SizedBox(
                            width: buttonsWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bookmark button
                                IconButton(
                                  onPressed: widget.onBookmarkTap,
                                  icon: const Icon(Icons.bookmark_border,
                                      size: 16),
                                  color: Colors.white,
                                  visualDensity: VisualDensity.compact,
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  padding: EdgeInsets.zero,
                                ),

                                const SizedBox(width: 2),

                                // Register button
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: widget.onRegisterTap,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.get('primary'),
                                      foregroundColor:
                                          theme.get('textOnPrimary'),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    child: const Text('Register',
                                        style: TextStyle(fontSize: 11)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
