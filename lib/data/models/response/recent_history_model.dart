class RecentHistory {
  final String gameSlug;
  final DateTime lastPlayed;
  final String title;
  final String? description;
  final String? companyName;
  final String? companyImage;
  final String? organizationId;
  final String imageUrl;
  final String esrb;
  final int? ratingCount;
  final double? rating;

  RecentHistory({
    required this.gameSlug,
    required this.lastPlayed,
    required this.title,
    this.description,
    this.companyName,
    this.companyImage,
    this.organizationId,
    required this.imageUrl,
    required this.esrb,
    this.ratingCount,
    this.rating,
  });

  factory RecentHistory.fromJson(Map<String, dynamic> json) {
    return RecentHistory(
      gameSlug: json['game_slug'] as String,
      lastPlayed: DateTime.parse(json['last_played'] as String),
      title: json['title'] as String,
      description: json['description'] as String?,
      companyName: json['company_name'] as String?,
      companyImage: json['company_image'] as String?,
      organizationId: json['organization_id'] as String?,
      imageUrl: json['image_url'] as String,
      esrb: json['esrb'] as String,
      ratingCount: json['rating_count'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_slug': gameSlug,
      'last_played': lastPlayed.toIso8601String(),
      'title': title,
      'description': description,
      'company_name': companyName,
      'company_image': companyImage,
      'organization_id': organizationId,
      'image_url': imageUrl,
      'esrb': esrb,
      'rating_count': ratingCount,
      'rating': rating,
    };
  }
}
