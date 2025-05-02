class QuestMissionModel {
  final int logicGroupId;
  final String logicGroupType;
  final String logicTitle;
  final String? companyId;
  final String? companyName;
  final String description;
  final int totalEvents;
  final bool isLogicGroupCompleted;
  final List<QuestMissionEvent> events;

  QuestMissionModel({
    required this.logicGroupId,
    required this.logicGroupType,
    required this.logicTitle,
    this.companyId,
    this.companyName,
    required this.description,
    required this.totalEvents,
    required this.isLogicGroupCompleted,
    required this.events,
  });

  factory QuestMissionModel.fromJson(Map<String, dynamic> json) {
    return QuestMissionModel(
      logicGroupId: json['logic_group_id'] ?? 0,
      logicGroupType: json['logic_group_type'] ?? '',
      logicTitle: json['logic_title'] ?? '',
      companyId: json['company_id'],
      companyName: json['company_name'],
      description: json['description'] ?? '',
      totalEvents: json['total_events'] ?? 0,
      isLogicGroupCompleted: json['is_logic_group_completed'] ?? false,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => QuestMissionEvent.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class QuestMissionEvent {
  final int id;
  final String name;
  final bool repeatable;
  final int points;
  final int eventCount;
  final int userEventCount;
  final int? repeatPeriod;
  final bool isCompleted;
  final String? gameSlug;
  final String? gameName;

  QuestMissionEvent({
    required this.id,
    required this.name,
    required this.repeatable,
    required this.points,
    required this.eventCount,
    required this.userEventCount,
    this.repeatPeriod,
    required this.isCompleted,
    this.gameSlug,
    this.gameName,
  });

  factory QuestMissionEvent.fromJson(Map<String, dynamic> json) {
    return QuestMissionEvent(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      repeatable: json['repeatable'] ?? false,
      points: json['points'] ?? 0,
      eventCount: json['event_count'] ?? 0,
      userEventCount: json['user_event_count'] ?? 0,
      repeatPeriod: json['repeat_period'],
      isCompleted: json['is_completed'] ?? false,
      gameSlug: json['game_slug'],
      gameName: json['game_name'],
    );
  }
}
