class FavoriteVideo {
  final String videoSlug;
  final String title;
  final String imageUrl;
  final String videoUrl;
  final String publisherAvatarUrl;
  final String publisherName;
  final int friendsWatchedCount;
  final DateTime createdAt;

  FavoriteVideo({
    required this.videoSlug,
    required this.title,
    required this.imageUrl,
    required this.videoUrl,
    required this.publisherAvatarUrl,
    required this.publisherName,
    required this.friendsWatchedCount,
    required this.createdAt,
  });

  factory FavoriteVideo.fromJson(Map<String, dynamic> json) {
    return FavoriteVideo(
      videoSlug: json['videoSlug'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      videoUrl: json['videoUrl'] as String,
      publisherAvatarUrl: json['publisherAvatarUrl'] as String,
      publisherName: json['publisherName'] as String,
      friendsWatchedCount: json['friendsWatchedCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoSlug': videoSlug,
      'title': title,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'publisherAvatarUrl': publisherAvatarUrl,
      'publisherName': publisherName,
      'friendsWatchedCount': friendsWatchedCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
