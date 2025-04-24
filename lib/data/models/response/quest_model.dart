class QuestModel {
  final String questId;
  final int priority;
  final dynamic processHistoricalEventFeed;
  final bool processedHistoricalEventFeed;
  final String name;
  final String questType;
  final String description;
  final String image;
  final String? imageSmall;
  final String? imageMedium;
  final String startTime;
  final String endTime;
  final String timezone;
  final bool completed;
  final String created;
  final String lastModified;
  final bool isCreatedByAdmin;
  final int totalMissions;
  final int missionCompleted;
  final int totalTask;
  final int taskCompleted;
  final String q;
  final String p;
  final List<String> awards;
  final List<Game> game;
  final int phyndCoins;
  final int phyndCoinsBonus;
  final String gameName;

  QuestModel({
    required this.questId,
    required this.priority,
    this.processHistoricalEventFeed,
    required this.processedHistoricalEventFeed,
    required this.name,
    required this.questType,
    required this.description,
    required this.image,
    this.imageSmall,
    this.imageMedium,
    required this.startTime,
    required this.endTime,
    required this.timezone,
    required this.completed,
    required this.created,
    required this.lastModified,
    required this.isCreatedByAdmin,
    required this.totalMissions,
    required this.missionCompleted,
    required this.totalTask,
    required this.taskCompleted,
    required this.q,
    required this.p,
    required this.awards,
    required this.game,
    required this.phyndCoins,
    required this.phyndCoinsBonus,
    required this.gameName,
  });

  factory QuestModel.fromJson(Map<String, dynamic> json) {
    return QuestModel(
      questId: json['quest_id'] ?? '',
      priority: json['priority'] ?? 0,
      processHistoricalEventFeed: json['process_historical_event_feed'],
      processedHistoricalEventFeed:
          json['processed_historical_event_feed'] ?? false,
      name: json['name'] ?? '',
      questType: json['quest_type'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      imageSmall: json['image_small'],
      imageMedium: json['image_medium'],
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      timezone: json['timezone'] ?? '',
      completed: json['completed'] ?? false,
      created: json['created'] ?? '',
      lastModified: json['last_modified'] ?? '',
      isCreatedByAdmin: json['is_created_by_admin'] ?? false,
      totalMissions: json['total_missions'] ?? 0,
      missionCompleted: json['mission_completed'] ?? 0,
      totalTask: json['total_task'] ?? 0,
      taskCompleted: json['task_completed'] ?? 0,
      q: json['q'] ?? '',
      p: json['p'] ?? '',
      awards: List<String>.from(json['awards'] ?? []),
      game: (json['game'] as List<dynamic>?)
              ?.map((gameJson) => Game.fromJson(gameJson))
              .toList() ??
          [],
      phyndCoins: json['phynd_coins'] ?? 0,
      phyndCoinsBonus: json['phynd_coins_bonus'] ?? 0,
      gameName: json['game_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quest_id': questId,
      'priority': priority,
      'process_historical_event_feed': processHistoricalEventFeed,
      'processed_historical_event_feed': processedHistoricalEventFeed,
      'name': name,
      'quest_type': questType,
      'description': description,
      'image': image,
      'image_small': imageSmall,
      'image_medium': imageMedium,
      'start_time': startTime,
      'end_time': endTime,
      'timezone': timezone,
      'completed': completed,
      'created': created,
      'last_modified': lastModified,
      'is_created_by_admin': isCreatedByAdmin,
      'total_missions': totalMissions,
      'mission_completed': missionCompleted,
      'total_task': totalTask,
      'task_completed': taskCompleted,
      'q': q,
      'p': p,
      'awards': awards,
      'game': game.map((g) => g.toJson()).toList(),
      'phynd_coins': phyndCoins,
      'phynd_coins_bonus': phyndCoinsBonus,
    };
  }
}

class Game {
  final String slug;
  final String name;

  Game({
    required this.slug,
    required this.name,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
    };
  }
}
