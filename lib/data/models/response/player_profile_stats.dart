class PlayerProfileStats {
  int? friendCount;
  String? id;
  int? mutualFriendCount;
  int? userFollowers;
  int? userFollowings;

  PlayerProfileStats(
      {this.friendCount,
      this.id,
      this.mutualFriendCount,
      this.userFollowers,
      this.userFollowings});

  PlayerProfileStats.fromJson(Map<String, dynamic> json) {
    friendCount = json['friend_count'];
    id = json['id'];
    mutualFriendCount = json['mutual_friend_count'];
    userFollowers = json['user_followers'];
    userFollowings = json['user_followings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friend_count'] = this.friendCount;
    data['id'] = this.id;
    data['mutual_friend_count'] = this.mutualFriendCount;
    data['user_followers'] = this.userFollowers;
    data['user_followings'] = this.userFollowings;
    return data;
  }
}
