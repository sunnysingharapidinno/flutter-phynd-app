class SavedEvent {
  final String title;
  final String imageUrl;
  final String? endDate;
  final String eventId;
  final int friendsSaved;
  final String startDate;
  final String? publisherId;
  final String? dpUrl;
  final bool? isVerified;
  final String? type;

  SavedEvent({
    required this.title,
    required this.imageUrl,
    this.endDate,
    required this.eventId,
    required this.friendsSaved,
    required this.startDate,
    this.publisherId,
    this.dpUrl,
    this.isVerified,
    this.type,
  });

  factory SavedEvent.fromJson(Map<String, dynamic> json) {
    return SavedEvent(
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      endDate: json['end_date'] as String?,
      eventId: json['event_id'] as String,
      friendsSaved: json['friends_saved'] as int,
      startDate: json['start_date'] as String,
      publisherId: json['publisher_id'] as String,
      dpUrl: json['dp_url'] as String,
      isVerified: json['is_verified'] as bool,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image_url': imageUrl,
      'end_date': endDate,
      'event_id': eventId,
      'friends_saved': friendsSaved,
      'start_date': startDate,
      'publisher_id': publisherId,
      'dp_url': dpUrl,
      'is_verified': isVerified,
      'type': type,
    };
  }
}
