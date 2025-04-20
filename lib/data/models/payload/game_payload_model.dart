class GamePayload {
  final List<String>? gameChain;
  final String? gameName;
  final String? network;
  final List<String>? categories;
  final String? sortBy;
  final bool? reverse;
  final String? externalCategory;
  final String? domain;
  final String? dateCreated;
  final String? dateModified;
  final bool? iframable;
  final List<String>? platform;
  final String? status;
  final List<String>? publisherId;
  final List<String>? tags;
  final bool? playNow;
  final List<String>? featuredType;
  final List<String>? studioId;
  final List<String>? developerId;

  GamePayload({
    this.gameChain,
    this.gameName,
    this.network,
    this.categories,
    this.sortBy,
    this.reverse,
    this.externalCategory,
    this.domain,
    this.dateCreated,
    this.dateModified,
    this.iframable,
    this.platform,
    this.status,
    this.publisherId,
    this.tags,
    this.playNow,
    this.featuredType,
    this.studioId,
    this.developerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'game_chain': gameChain,
      'gameName': gameName,
      'network': network,
      'categories': categories,
      'sortby': sortBy,
      'reverse': reverse,
      'external_category': externalCategory,
      'domain': domain,
      'date_created': dateCreated,
      'date_modified': dateModified,
      'iframable': iframable,
      'platform': platform,
      'status': status,
      'publisher_id': publisherId,
      'tags': tags,
      'playNow': playNow,
      'featured_type': featuredType,
      'studio_id': studioId,
      'developer_id': developerId,
    };
  }

  factory GamePayload.fromJson(Map<String, dynamic> json) {
    return GamePayload(
      gameChain: (json['game_chain'] as List?)?.cast<String>(),
      gameName: json['gameName'],
      network: json['network'],
      categories: (json['categories'] as List?)?.cast<String>(),
      sortBy: json['sortby'],
      reverse: json['reverse'],
      externalCategory: json['external_category'],
      domain: json['domain'],
      dateCreated: json['date_created'],
      dateModified: json['date_modified'],
      iframable: json['iframable'],
      platform: (json['platform'] as List?)?.cast<String>(),
      status: json['status'],
      publisherId: (json['publisher_id'] as List?)?.cast<String>(),
      tags: (json['tags'] as List?)?.cast<String>(),
      playNow: json['playNow'],
      featuredType: (json['featured_type'] as List?)?.cast<String>(),
      studioId: (json['studio_id'] as List?)?.cast<String>(),
      developerId: (json['developer_id'] as List?)?.cast<String>(),
    );
  }
}
