class LikeFollowStatus {
  String? gameSlug;
  bool? isFavourite;
  bool? isFollow;

  LikeFollowStatus({this.gameSlug, this.isFavourite, this.isFollow});

  LikeFollowStatus.fromJson(Map<String, dynamic> json) {
    gameSlug = json['game_slug'];
    isFavourite = json['is_favourite'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_slug'] = this.gameSlug;
    data['is_favourite'] = this.isFavourite;
    data['is_follow'] = this.isFollow;
    return data;
  }
}
