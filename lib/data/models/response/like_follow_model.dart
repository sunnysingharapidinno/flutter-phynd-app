class LikeFollowStatus {
  String? gameSlug;
  bool? isFavorite;
  bool? isFollow;

  LikeFollowStatus({this.gameSlug, this.isFavorite, this.isFollow});

  LikeFollowStatus.fromJson(Map<String, dynamic> json) {
    gameSlug = json['game_slug'];
    isFavorite = json['is_favourite'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_slug'] = this.gameSlug;
    data['is_favourite'] = this.isFavorite;
    data['is_follow'] = this.isFollow;
    return data;
  }
}
