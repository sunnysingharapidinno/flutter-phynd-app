class PubGenre {
  String? id;
  String? slug;
  String? name;
  String? imageUrl;
  String? description;
  bool? isEnabled;
  int? version;

  PubGenre(
      {this.id,
      this.slug,
      this.name,
      this.imageUrl,
      this.description,
      this.isEnabled,
      this.version});

  PubGenre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    imageUrl = json['image_url'];
    description = json['description'];
    isEnabled = json['is_enabled'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    data['is_enabled'] = this.isEnabled;
    data['version'] = this.version;
    return data;
  }
}
