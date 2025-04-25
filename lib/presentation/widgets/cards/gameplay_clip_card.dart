import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';

class GameplayClipCard extends StatefulWidget {
  final String thumbnailUrl;
  final String timeAgo;
  final String duration;
  final String username;
  final String userAvatarUrl;
  final bool isVerified;
  final String clipTitle;
  final int friendsWatched;
  final List<String> friendAvatarUrls;

  const GameplayClipCard({
    super.key,
    required this.thumbnailUrl,
    required this.timeAgo,
    required this.duration,
    required this.username,
    required this.userAvatarUrl,
    this.isVerified = false,
    required this.clipTitle,
    this.friendsWatched = 0,
    this.friendAvatarUrls = const [],
  });

  @override
  State<GameplayClipCard> createState() => _GameplayClipCardState();
}

class _GameplayClipCardState extends State<GameplayClipCard> {
  final FocusNode _focusNode = FocusNode();
  bool _isHovered = false;

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Focus(
          focusNode: _focusNode,
          child: Container(
            width: 320,
            margin: const EdgeInsets.only(right: 16, bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black26,
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Make the card as small as possible
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail with time indicators
                Stack(
                  children: [
                    // Thumbnail image
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        widget.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                              child: Icon(Icons.broken_image,
                                  color: Colors.white)),
                        ),
                      ),
                    ),

                    // Time ago indicator
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.timeAgo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // Duration indicator
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // User info and clip details
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User info row
                      Row(
                        children: [
                          // User avatar
                          CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(widget.userAvatarUrl),
                            backgroundColor: Colors.grey.shade800,
                            onBackgroundImageError: (exception, stackTrace) {
                              // Handle image loading error
                            },
                          ),
                          const SizedBox(width: 8),

                          // Username with verification badge
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (widget.isVerified)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Icon(
                                      Icons.verified,
                                      color: Colors.deepPurple,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Clip title
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Text(
                          widget.clipTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Friends watched section
                      if (widget.friendsWatched > 0)
                        Row(
                          children: [
                            const Icon(Icons.people,
                                color: Colors.white70, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.friendsWatched} Friends Watched',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),

                            // Friend avatars
                            if (widget.friendAvatarUrls.isNotEmpty)
                              SizedBox(
                                height: 24,
                                width:
                                    widget.friendAvatarUrls.length * 16.0 + 8,
                                child: Stack(
                                  children: [
                                    for (int i = 0;
                                        i < widget.friendAvatarUrls.length &&
                                            i < 5;
                                        i++)
                                      Positioned(
                                        left: i * 16.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black26,
                                                width: 1),
                                          ),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundImage: NetworkImage(
                                                widget.friendAvatarUrls[i]),
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            onBackgroundImageError:
                                                (exception, stackTrace) {
                                              // Handle image loading error
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
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
        ),
      ),
    );
  }
}
