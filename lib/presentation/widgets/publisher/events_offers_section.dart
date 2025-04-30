import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/common/profile_avatar_stack.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class EventsOffersSection extends StatelessWidget {
  final List<Map<String, dynamic>> eventsOffers;
  final Color primaryColor;
  final Color textColor;

  const EventsOffersSection({
    Key? key,
    required this.eventsOffers,
    required this.primaryColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eventsOffers.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Events and Offers',
          onSeeAllPressed: () {
            // Handle see all press
          },
          accentColor: primaryColor,
          textColor: textColor,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250, // Fixed height for row
          child: Row(
            children: [
              if (eventsOffers.isNotEmpty)
                Expanded(
                  flex: 1,
                  child: EventOfferCard(
                    imageUrl: eventsOffers[0]['imageUrl'],
                    title: eventsOffers[0]['title'],
                    timeRemaining: eventsOffers[0]['timeRemaining'],
                    friendsCount: eventsOffers[0]['friendsCount'],
                    friendAvatars:
                        List<String>.from(eventsOffers[0]['friendAvatars']),
                    actionText: eventsOffers[0]['actionText'],
                    isEvent: eventsOffers[0]['type'] == 'event',
                    primaryColor: primaryColor,
                    textColor: textColor,
                  ),
                ),
              const SizedBox(width: 16),
              if (eventsOffers.length > 1)
                Expanded(
                  flex: 1,
                  child: EventOfferCard(
                    imageUrl: eventsOffers[1]['imageUrl'],
                    title: eventsOffers[1]['title'],
                    timeRemaining: eventsOffers[1]['timeRemaining'],
                    friendsCount: eventsOffers[1]['friendsCount'],
                    friendAvatars:
                        List<String>.from(eventsOffers[1]['friendAvatars']),
                    actionText: eventsOffers[1]['actionText'],
                    isEvent: eventsOffers[1]['type'] == 'event',
                    primaryColor: primaryColor,
                    textColor: textColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class EventOfferCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String? timeRemaining;
  final int friendsCount;
  final List<String> friendAvatars;
  final String actionText;
  final bool isEvent;
  final Color primaryColor;
  final Color textColor;

  const EventOfferCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.timeRemaining,
    required this.friendsCount,
    required this.friendAvatars,
    required this.actionText,
    required this.isEvent,
    required this.primaryColor,
    required this.textColor,
  }) : super(key: key);

  @override
  State<EventOfferCard> createState() => _EventOfferCardState();
}

class _EventOfferCardState extends State<EventOfferCard> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RemoteControlWrapper(
      focusNode: _focusNode,
      onTap: () {
        // Handle card tap
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card image with bookmark button
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    height: 145,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Bookmark button
                Positioned(
                  top: 8,
                  right: 8,
                  child: RemoteControlWrapper(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          // Handle bookmark action
                        },
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),

                // Time remaining (for events)
                if (widget.timeRemaining != null)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.timeRemaining!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Card content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Friends joining and Action button in a row
                  Row(
                    children: [
                      // Friends joining
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.isEvent
                                    ? '${widget.friendsCount} friends joined'
                                    : '${widget.friendsCount} friends bought',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            ProfileAvatarStack(
                              avatarUrls: widget.friendAvatars.isEmpty
                                  ? []
                                  : widget.friendAvatars
                                      .take(widget.friendAvatars.length)
                                      .toList(),
                              avatarSize: 20,
                            ),
                          ],
                        ),
                      ),

                      // Action button
                      RemoteControlWrapper(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle action button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.primaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            widget.actionText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
