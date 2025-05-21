class GameFollow {
  String? slug;
  String? thumbnail;
  String? name;
  String? title;
  String? userId;

  GameFollow({this.slug, this.thumbnail, this.name, this.title, this.userId});

  GameFollow.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    name = json['name'];
    title = json['title'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['thumbnail'] = this.thumbnail;
    data['name'] = this.name;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    return data;
  }
}
