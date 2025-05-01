import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/data/services/quest_service.dart';

class QuestMissionsSection extends StatefulWidget {
  final QuestModel questData;

  const QuestMissionsSection({
    super.key,
    required this.questData,
  });

  @override
  State<QuestMissionsSection> createState() => _QuestMissionsSectionState();
}

class _QuestMissionsSectionState extends State<QuestMissionsSection> {
  final QuestService _questService = QuestService();
  List<QuestMissionModel>? _questMissions;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _getQuestMissions();
  }

  Future<void> _getQuestMissions() async {
    try {
      final String questId = widget.questData.questId ?? '';

      if (questId.isNotEmpty) {
        final response = await _questService.getQuestMissions(questId: questId);

        setState(() {
          _questMissions = response;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError || _questMissions == null) {
      return const Center(
        child: Text(
          'Failed to load missions',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    if (_questMissions!.isEmpty) {
      return const Center(
        child: Text(
          'No missions available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _questMissions!.map((group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logic Group Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F3543),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade800,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  group.logicGroupType == 'ALL'
                      ? 'Complete all of the following'
                      : 'Complete any of the following',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Mission Items
              ...group.events.map((event) => Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F3543),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade800,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (event.eventCount > 0) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Count ${event.userEventCount}/${event.eventCount}',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: event.isCompleted
                                ? Colors.green
                                : Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: event.isCompleted
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 24,
                                )
                              : null,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 16), // Spacing between groups
            ],
          );
        }).toList(),
      ),
    );
  }
}
