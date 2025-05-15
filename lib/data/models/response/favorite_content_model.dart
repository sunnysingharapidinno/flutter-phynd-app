import 'package:phynd_app/core/enums/media_type.dart';

class FavoriteContent {
  final String gameSlug;
  final String url;
  final String? title;
  final DateTime createdAt;
  final String description;
  final MediaType mediaType;
  final String? companyName;
  final String? gameTitle;
  final String? organizationId;
  final String? companyImage;

  FavoriteContent({
    required this.gameSlug,
    required this.url,
    required this.createdAt,
    required this.description,
    required this.mediaType,
    this.title,
    this.companyName,
    this.gameTitle,
    this.organizationId,
    this.companyImage,
  });

  factory FavoriteContent.fromJson(Map<String, dynamic> json) {
    return FavoriteContent(
      gameSlug: json['game_slug'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      description: json['description'] as String,
      mediaType: MediaType.values.firstWhere(
        (e) => e.value == json['media_type'],
        orElse: () => MediaType.image,
      ),
      companyName: json['company_name'] as String?,
      gameTitle: json['game_title'] as String?,
      organizationId: json['organization_id'] as String?,
      companyImage: json['company_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_slug': gameSlug,
      'url': url,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'description': description,
      'media_type': mediaType.value,
      'company_name': companyName,
      'game_title': gameTitle,
      'organization_id': organizationId,
      'company_image': companyImage,
    };
  }
}
