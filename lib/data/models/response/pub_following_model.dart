class PubFollowing {
  String? followingDisplayName;
  String? followingDpUrl;
  String? followingId;
  String? id;
  bool? isFollowing;
  bool? isPublisher;
  String? userId;

  PubFollowing(
      {this.followingDisplayName,
      this.followingDpUrl,
      this.followingId,
      this.id,
      this.isFollowing,
      this.isPublisher,
      this.userId});

  PubFollowing.fromJson(Map<String, dynamic> json) {
    followingDisplayName = json['following_display_name'];
    followingDpUrl = json['following_dp_url'];
    followingId = json['following_id'];
    id = json['id'];
    isFollowing = json['is_following'];
    isPublisher = json['is_publisher'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following_display_name'] = this.followingDisplayName;
    data['following_dp_url'] = this.followingDpUrl;
    data['following_id'] = this.followingId;
    data['id'] = this.id;
    data['is_following'] = this.isFollowing;
    data['is_publisher'] = this.isPublisher;
    data['user_id'] = this.userId;
    return data;
  }
}
