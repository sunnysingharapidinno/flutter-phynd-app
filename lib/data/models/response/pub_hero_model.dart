class PubHero {
  String? createdAt;
  String? heroImageUrl;
  String? id;
  String? modifiedBy;
  String? pubId;
  String? pubLogoUrl;
  String? updatedAt;
  int? version;

  PubHero(
      {this.createdAt,
      this.heroImageUrl,
      this.id,
      this.modifiedBy,
      this.pubId,
      this.pubLogoUrl,
      this.updatedAt,
      this.version});

  PubHero.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    heroImageUrl = json['hero_image_url'];
    id = json['id'];
    modifiedBy = json['modified_by'];
    pubId = json['pub_id'];
    pubLogoUrl = json['pub_logo_url'];
    updatedAt = json['updated_at'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['hero_image_url'] = this.heroImageUrl;
    data['id'] = this.id;
    data['modified_by'] = this.modifiedBy;
    data['pub_id'] = this.pubId;
    data['pub_logo_url'] = this.pubLogoUrl;
    data['updated_at'] = this.updatedAt;
    data['version'] = this.version;
    return data;
  }
}
