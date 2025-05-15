class FriendItem {
  String? id;
  String? userId;
  String? friendId;
  String? friendFirstName;
  String? friendLastName;
  String? friendDisplayName;
  String? friendDisplayNameSlug;
  String? friendDpUrl;
  String? createdAt;

  FriendItem(
      {this.id,
      this.userId,
      this.friendId,
      this.friendFirstName,
      this.friendLastName,
      this.friendDisplayName,
      this.friendDisplayNameSlug,
      this.friendDpUrl,
      this.createdAt});

  FriendItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendId = json['friend_id'];
    friendFirstName = json['friend_first_name'];
    friendLastName = json['friend_last_name'];
    friendDisplayName = json['friend_display_name'];
    friendDisplayNameSlug = json['friend_display_name_slug'];
    friendDpUrl = json['friend_dp_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['friend_id'] = this.friendId;
    data['friend_first_name'] = this.friendFirstName;
    data['friend_last_name'] = this.friendLastName;
    data['friend_display_name'] = this.friendDisplayName;
    data['friend_display_name_slug'] = this.friendDisplayNameSlug;
    data['friend_dp_url'] = this.friendDpUrl;
    data['created_at'] = this.createdAt;
    return data;
  }
}
