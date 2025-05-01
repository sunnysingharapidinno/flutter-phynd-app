import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/data/services/quest_service.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_header.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_creator_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_rewards_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_missions_section.dart';

class QuestDetailsPage extends StatefulWidget {
  final String questId;

  const QuestDetailsPage({
    super.key,
    required this.questId,
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
    _getQuestDetails();
  }

  Future<void> _getQuestDetails() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final quest =
          await _questService.getQuestDetails(questId: widget.questId);

      if (mounted) {
        setState(() {
          _questDetails = quest;
          _isLoading = false;
          _hasError = false;
        });
      }
    } catch (e) {
      print('Error fetching quest details: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
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
                  _getQuestDetails();
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
