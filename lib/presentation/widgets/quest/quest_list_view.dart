import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/data/services/quest_service.dart';
import 'package:phynd_app/presentation/screens/quest_details_page.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_in_progress_card.dart';

class QuestListView extends StatefulWidget {
  const QuestListView({Key? key}) : super(key: key);

  @override
  State<QuestListView> createState() => _QuestListViewState();
}

class _QuestListViewState extends State<QuestListView> {
  final QuestService _questService = QuestService();
  List<QuestModel> _quests = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchQuests();
  }

  Future<void> _fetchQuests() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final quests = await _questService.getUserQuests(
        page: 1,
        limit: 10,
      );

      setState(() {
        _quests = quests;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchQuests,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_quests.isEmpty) {
      return const Center(
        child: Text('No quests available'),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchQuests,
      child: ListView.builder(
        itemCount: _quests.length,
        itemBuilder: (context, index) {
          final quest = _quests[index];
          return QuestInProgressCard(
            imageUrl: quest.image,
            title: quest.name,
            gameName: quest.gameName,
            completedMissions: quest.missionCompleted ?? 0,
            totalMissions: quest.totalMissions ?? 1,
            questId: quest.questId,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestDetailsPage(
                    questId: quest.questId,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
