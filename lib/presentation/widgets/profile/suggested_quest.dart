import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/services/quest_service.dart';
import 'package:phynd_app/presentation/screens/quest_details_page.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_in_progress_card.dart';

class SuggestedQuest extends StatefulWidget {
  final String title;
  final bool? isTrending;
  final bool? isFeatured;
  final String? sortBy;
  const SuggestedQuest({
    super.key,
    this.title = 'Suggested Quests',
    this.isTrending,
    this.isFeatured,
    this.sortBy,
  });

  @override
  State<SuggestedQuest> createState() => _SuggestedQuestState();
}

class _SuggestedQuestState extends State<SuggestedQuest> {
  final QuestService _questService = QuestService();
  List<Map<String, dynamic>> _quests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuests();
  }

  Future<void> _fetchQuests() async {
    try {
      final result = await _questService.getQuests(
        sort_by: widget.sortBy ?? 'RECENTLY_CREATED',
        is_featured: widget.isFeatured,
        is_trending: widget.isTrending,
        page: 1,
        limit: 12,
      );

      setState(() {
        // result is already a List<QuestModel> from getUserQuests
        _quests = result.map((questModel) => questModel.toJson()).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching quests: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text') ?? Colors.white;
    final primaryColor = theme?.get('primary') ?? Colors.blue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SectionHeading(
              title: widget.title,
              textColor: textColor,
              accentColor: primaryColor,
              onSeeAllPressed: () {
                // View all quests
              },
            ),
          ),
          const SizedBox(height: 8),
          // Cards
          SizedBox(
            height: 320,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _quests.isEmpty
                    ? Center(
                        child: Text(
                          'No suggested quests',
                          style: TextStyle(color: textColor),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: _quests.length,
                        itemBuilder: (context, index) {
                          final quest = _quests[index];
                          return QuestInProgressCard(
                            imageUrl: quest['image'] ??
                                'https://xstrela-alpha.s3.amazonaws.com/images/quest_default.jpg',
                            title: quest['name'] ?? 'Unknown Quest',
                            gameName: quest['game_name'] ?? 'Unknown Game',
                            completedMissions: quest['completed_missions'] ?? 0,
                            totalMissions: quest['total_missions'] ?? 1,
                            cardColor: _getCardColor(index),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const QuestDetailsPage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Color _getCardColor(int index) {
    // Cycle through colors for different quests
    final colors = [
      Colors.amber,
      Colors.teal,
      Colors.deepPurple,
      Colors.indigo,
      Colors.pink,
    ];

    return colors[index % colors.length];
  }
}
