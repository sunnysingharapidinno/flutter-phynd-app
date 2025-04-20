import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final bool isPublisher;
  final bool isPublisherBlocked;
  final bool isUserBanned;
  final bool isUserBlocked;
  final String? publisherBlockedReason;
  final String? userBanReason;
  final String? userBlockedReason;

  const User({
    required this.email,
    this.isPublisher = false,
    this.isPublisherBlocked = false,
    this.isUserBanned = false,
    this.isUserBlocked = false,
    this.publisherBlockedReason,
    this.userBanReason,
    this.userBlockedReason,
  });

  @override
  List<Object?> get props => [
        email,
        isPublisher,
        isPublisherBlocked,
        isUserBanned,
        isUserBlocked,
        publisherBlockedReason,
        userBanReason,
        userBlockedReason,
      ];
}
