class LikeFollowStatus {
  final String gameSlug;
  final bool isFavorite;
  final bool isFollow;
  final int friendsCount;

  LikeFollowStatus({
    required this.gameSlug,
    required this.isFavorite,
    required this.isFollow,
    required this.friendsCount,
  });

  factory LikeFollowStatus.fromJson(Map<String, dynamic> json) {
    return LikeFollowStatus(
      gameSlug: json['game_slug'],
      isFavorite: json['is_favourite'],
      isFollow: json['is_follow'],
      friendsCount: json['friends_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_slug': gameSlug,
      'is_favourite': isFavorite,
      'is_follow': isFollow,
      'friends_count': friendsCount,
    };
  }
}
