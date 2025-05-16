class PlayerProfileGame {
  String? slug;
  String? name;
  Null title;
  String? thumbnail;
  Null imageUrl;
  String? esrbRatingImgUrl;
  String? userId;
  String? userDisplayName;
  String? userDisplayNameSlug;
  String? userDpUrl;

  PlayerProfileGame(
      {this.slug,
      this.name,
      this.title,
      this.thumbnail,
      this.imageUrl,
      this.esrbRatingImgUrl,
      this.userId,
      this.userDisplayName,
      this.userDisplayNameSlug,
      this.userDpUrl});

  PlayerProfileGame.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    imageUrl = json['image_url'];
    esrbRatingImgUrl = json['esrb_rating_img_url'];
    userId = json['user_id'];
    userDisplayName = json['user_display_name'];
    userDisplayNameSlug = json['user_display_name_slug'];
    userDpUrl = json['user_dp_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['image_url'] = this.imageUrl;
    data['esrb_rating_img_url'] = this.esrbRatingImgUrl;
    data['user_id'] = this.userId;
    data['user_display_name'] = this.userDisplayName;
    data['user_display_name_slug'] = this.userDisplayNameSlug;
    data['user_dp_url'] = this.userDpUrl;
    return data;
  }
}
