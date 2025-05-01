import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/data/services/quest_service.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_header.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_creator_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_rewards_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_missions_section.dart';

class QuestDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? questData;

  const QuestDetailsPage({
    super.key,
    this.questData,
  });

  @override
  State<QuestDetailsPage> createState() => _QuestDetailsPageState();
}

class _QuestDetailsPageState extends State<QuestDetailsPage> {
  final QuestService _questService = QuestService();
  QuestModel? _questDetails;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _getQuestDetails(widget.questData);
  }

  Future<void> _getQuestDetails(Map<String, dynamic>? questData) async {
    try {
      if (questData != null) {
        final String questId = questData['quest_id'] ?? '';
        if (questId.isNotEmpty) {
          final quest = await _questService.getQuestDetails(questId: questId);
          print('quest: $quest');
          setState(() {
            _questDetails = quest;
            _isLoading = false;
          });
        } else {
          setState(() {
            _questDetails = QuestModel.fromJson(questData);
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      debugPrint('Error fetching quest details: $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError || _questDetails == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to load quest details',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _hasError = false;
                  });
                  _getQuestDetails(widget.questData);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.more_horiz, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),

          // Quest Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  QuestHeader(
                    questData: _questDetails!,
                  ),
                  QuestCreatorSection(
                    questData: _questDetails!,
                  ),
                  QuestRewardsSection(
                    questData: _questDetails!,
                  ),
                  QuestMissionsSection(
                    questData: _questDetails!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
