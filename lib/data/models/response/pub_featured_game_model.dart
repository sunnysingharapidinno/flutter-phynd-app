class PubFeaturedGame {
  String? name;
  String? slug;
  double? starRatings;
  String? esrbImgUrl;
  String? coverUrl;

  PubFeaturedGame(
      {this.name, this.slug, this.starRatings, this.esrbImgUrl, this.coverUrl});

  PubFeaturedGame.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    starRatings = json['star_ratings'];
    esrbImgUrl = json['esrb_img_url'];
    coverUrl = json['cover_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['star_ratings'] = this.starRatings;
    data['esrb_img_url'] = this.esrbImgUrl;
    data['cover_url'] = this.coverUrl;
    return data;
  }
}
