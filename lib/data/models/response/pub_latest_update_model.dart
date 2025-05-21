class PubLatestUpdate {
  String? id;
  String? title;
  String? pubId;
  String? imageUrl;
  String? videoUrl;
  int? duration;
  String? modifiedBy;
  String? createdAt;
  String? updatedAt;
  int? version;

  PubLatestUpdate(
      {this.id,
      this.title,
      this.pubId,
      this.imageUrl,
      this.videoUrl,
      this.duration,
      this.modifiedBy,
      this.createdAt,
      this.updatedAt,
      this.version});

  PubLatestUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pubId = json['pub_id'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    duration = json['duration'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['pub_id'] = this.pubId;
    data['image_url'] = this.imageUrl;
    data['video_url'] = this.videoUrl;
    data['duration'] = this.duration;
    data['modified_by'] = this.modifiedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['version'] = this.version;
    return data;
  }
}
