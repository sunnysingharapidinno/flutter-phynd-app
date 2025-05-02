import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:phynd_app/data/services/quest_service.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_header.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_creator_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_rewards_section.dart';
import 'package:phynd_app/presentation/widgets/quest/quest_missions_section.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

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
      return BaseLayout(
        title: 'Quest Details',
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError || _questDetails == null) {
      return BaseLayout(
        title: 'Quest Details',
        child: Center(
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

    return BaseLayout(
      title: 'Quest Details',
      child: CustomScrollView(
        slivers: [
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
