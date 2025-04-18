import 'package:equatable/equatable.dart';

class CompanyDetails extends Equatable {
  final String? name;
  final String? address;
  final String? website;
  final String? description;

  const CompanyDetails({
    this.name,
    this.address,
    this.website,
    this.description,
  });

  @override
  List<Object?> get props => [name, address, website, description];
}

class UserProfile extends Equatable {
  final String id;
  final String first_name;
  final String last_name;
  final String email;
  final String? dp_url;
  final bool is_admin;
  final bool is_publisher;
  final bool is_publisher_blocked;
  final bool is_user_baned;
  final bool is_user_blocked;
  final String? publisher_blocked_reason;
  final String? user_ban_reason;
  final String? user_blocked_reason;
  final List<String> roles;

  const UserProfile({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    this.dp_url,
    required this.is_admin,
    required this.is_publisher,
    required this.is_publisher_blocked,
    required this.is_user_baned,
    required this.is_user_blocked,
    this.publisher_blocked_reason,
    this.user_ban_reason,
    this.user_blocked_reason,
    required this.roles,
  });

  @override
  List<Object?> get props => [
        id,
        first_name,
        last_name,
        email,
        dp_url,
        is_admin,
        is_publisher,
        is_publisher_blocked,
        is_user_baned,
        is_user_blocked,
        publisher_blocked_reason,
        user_ban_reason,
        user_blocked_reason,
        roles,
      ];
}

class SocialProfile extends Equatable {
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;
  final String? youtube;
  final String? website;

  const SocialProfile({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
    this.website,
  });

  @override
  List<Object?> get props => [
        facebook,
        twitter,
        instagram,
        linkedin,
        youtube,
        website,
      ];
}

class Profile extends Equatable {
  final UserProfile user;
  final SocialProfile social;

  const Profile({
    required this.user,
    required this.social,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: UserProfile(
        id: json['id'] as String,
        first_name: json['first_name'] as String,
        last_name: json['last_name'] as String,
        email: json['email'] as String,
        dp_url: json['dp_url'] as String?,
        is_admin: json['is_admin'] as bool,
        is_publisher: json['is_publisher'] as bool,
        is_publisher_blocked: json['is_publisher_blocked'] as bool,
        is_user_baned: json['is_user_baned'] as bool,
        is_user_blocked: json['is_user_blocked'] as bool,
        publisher_blocked_reason: json['publisher_blocked_reason'] as String?,
        user_ban_reason: json['user_ban_reason'] as String?,
        user_blocked_reason: json['user_blocked_reason'] as String?,
        roles: (json['roles'] as List).map((e) => e as String).toList(),
      ),
      social: SocialProfile(
        facebook: json['facebook'] as String?,
        twitter: json['twitter'] as String?,
        instagram: json['instagram'] as String?,
        linkedin: json['linkedin'] as String?,
        youtube: json['youtube'] as String?,
        website: json['website'] as String?,
      ),
    );
  }

  @override
  List<Object?> get props => [user, social];
}
