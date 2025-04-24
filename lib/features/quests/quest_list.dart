import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/data/services/quest_service.dart';

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
          return QuestCard(quest: quest);
        },
      ),
    );
  }
}

class QuestCard extends StatelessWidget {
  final QuestModel quest;

  const QuestCard({
    Key? key,
    required this.quest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quest image
            if (quest.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  quest.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),

            // Quest name and type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    quest.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    quest.questType,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue[800],
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Quest description
            Text(
              quest.description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Games
            if (quest.game.isNotEmpty) ...[
              const Text('Games:'),
              Wrap(
                spacing: 8,
                children: quest.game
                    .map((game) => Chip(
                          label: Text(game.name),
                          backgroundColor: Colors.green[100],
                          labelStyle: TextStyle(color: Colors.green[800]),
                        ))
                    .toList(),
              ),
            ],

            // Progress
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: quest.totalTask > 0
                  ? quest.taskCompleted / quest.totalTask
                  : 0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 4),
            Text(
              'Progress: ${quest.taskCompleted}/${quest.totalTask} tasks completed',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            // Rewards
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber[700], size: 20),
                const SizedBox(width: 4),
                Text(
                  '${quest.phyndCoins} coins',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (quest.phyndCoinsBonus > 0) ...[
                  const SizedBox(width: 8),
                  Text(
                    '+${quest.phyndCoinsBonus} bonus',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green[700],
                        ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
