class PubFeaturedGame {
  String? esrbImgUrl;
  String? name;
  double? starRatings;

  PubFeaturedGame({this.esrbImgUrl, this.name, this.starRatings});

  PubFeaturedGame.fromJson(Map<String, dynamic> json) {
    esrbImgUrl = json['esrb_img_url'];
    name = json['name'];
    starRatings = json['star_ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['esrb_img_url'] = this.esrbImgUrl;
    data['name'] = this.name;
    data['star_ratings'] = this.starRatings;
    return data;
  }
}
