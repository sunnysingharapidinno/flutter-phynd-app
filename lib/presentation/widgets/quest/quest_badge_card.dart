import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/remote_control_wrapper.dart';

class QuestBadgeCard extends StatefulWidget {
  final String title;
  final String level;
  final String badgeImageUrl;
  final String reward;
  final int missions;
  final int completedMissions;
  final int totalMissions;
  final VoidCallback? onTap;

  const QuestBadgeCard({
    super.key,
    required this.title,
    required this.level,
    required this.badgeImageUrl,
    required this.reward,
    required this.missions,
    required this.completedMissions,
    required this.totalMissions,
    this.onTap,
  });

  @override
  State<QuestBadgeCard> createState() => _QuestBadgeCardState();
}

class _QuestBadgeCardState extends State<QuestBadgeCard> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RemoteControlWrapper(
      onTap: widget.onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2F3A),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              widget.level,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Image.network(
              widget.badgeImageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Reward: ${widget.reward}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Text(
              'Missions: ${widget.missions}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: widget.totalMissions > 0
                    ? widget.completedMissions / widget.totalMissions
                    : 0,
                minHeight: 12,
                backgroundColor: Colors.white.withOpacity(0.15),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFFB18AFF)),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Completed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${widget.completedMissions}/${widget.totalMissions}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
