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

  factory CompanyDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CompanyDetails();

    return CompanyDetails(
      name: json['name'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props => [name, address, website, description];
}

class UserProfile extends Equatable {
  final String id;
  final String first_name;
  final String last_name;
  final String email;
  final bool? is_admin;
  final String? dp_url;
  final String? cover_image_url;
  final bool is_disabled;
  final bool is_verified;
  final String display_name;
  final bool two_factor_auth_enable;
  final String? bio;
  final bool is_kba_enabled;
  final bool is_secured;
  final bool tooltip;
  final String? timezone;
  final int timezone_offset;
  final String? timezone_locale;
  final String? avatar_id;
  final bool is_publisher;
  final bool is_publisher_approved;
  final bool isOrganization;
  final bool is_authorized;
  final bool is_publisher_blocked;
  final bool is_user_ban;
  final bool is_user_blocked;
  final String? user_ban_reason;
  final String? user_blocked_reason;
  final String? publisher_blocked_reason;
  final bool applied_for_publisher;
  final String logged_in_as;
  final bool company_detail_added;
  final String joined_as_user_on;
  final String joined_as_publisher_on;
  final CompanyDetails? company_details;
  final String publisher_request_status;
  final List<String> roles;
  final bool is_publisher_ban;

  const UserProfile({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    this.is_admin,
    this.dp_url,
    this.cover_image_url,
    required this.is_disabled,
    required this.is_verified,
    required this.display_name,
    required this.two_factor_auth_enable,
    this.bio,
    required this.is_kba_enabled,
    required this.is_secured,
    required this.tooltip,
    this.timezone,
    required this.timezone_offset,
    this.timezone_locale,
    this.avatar_id,
    required this.is_publisher,
    required this.is_publisher_approved,
    required this.isOrganization,
    required this.is_authorized,
    required this.is_publisher_blocked,
    required this.is_user_ban,
    required this.is_user_blocked,
    this.user_ban_reason,
    this.user_blocked_reason,
    this.publisher_blocked_reason,
    required this.applied_for_publisher,
    required this.logged_in_as,
    required this.company_detail_added,
    required this.joined_as_user_on,
    required this.joined_as_publisher_on,
    this.company_details,
    required this.publisher_request_status,
    required this.roles,
    required this.is_publisher_ban,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      email: json['email'] as String,
      is_admin: json['is_admin'] as bool?,
      dp_url: json['dp_url'] as String?,
      cover_image_url: json['cover_image_url'] as String?,
      is_disabled: json['is_disabled'] as bool? ?? false,
      is_verified: json['is_verified'] as bool? ?? false,
      display_name: json['display_name'] as String? ?? '',
      two_factor_auth_enable: json['two_factor_auth_enable'] as bool? ?? false,
      bio: json['bio'] as String?,
      is_kba_enabled: json['is_kba_enabled'] as bool? ?? false,
      is_secured: json['is_secured'] as bool? ?? false,
      tooltip: json['tooltip'] as bool? ?? false,
      timezone: json['timezone'] as String?,
      timezone_offset: json['timezone_offset'] as int? ?? 0,
      timezone_locale: json['timezone_locale'] as String?,
      avatar_id: json['avatar_id'] as String?,
      is_publisher: json['is_publisher'] as bool? ?? false,
      is_publisher_approved: json['is_publisher_approved'] as bool? ?? false,
      isOrganization: json['isOrganization'] as bool? ?? false,
      is_authorized: json['is_authorized'] as bool? ?? false,
      is_publisher_blocked: json['is_publisher_blocked'] as bool? ?? false,
      is_user_ban: json['is_user_ban'] as bool? ?? false,
      is_user_blocked: json['is_user_blocked'] as bool? ?? false,
      user_ban_reason: json['user_ban_reason'] as String?,
      user_blocked_reason: json['user_blocked_reason'] as String?,
      publisher_blocked_reason: json['publisher_blocked_reason'] as String?,
      applied_for_publisher: json['applied_for_publisher'] as bool? ?? false,
      logged_in_as: json['logged_in_as'] as String? ?? 'PLAYER',
      company_detail_added: json['company_detail_added'] as bool? ?? false,
      joined_as_user_on: json['joined_as_user_on'] as String? ?? '',
      joined_as_publisher_on: json['joined_as_publisher_on'] as String? ?? '',
      company_details: CompanyDetails.fromJson(
          json['company_details'] as Map<String, dynamic>?),
      publisher_request_status:
          json['publisher_request_status'] as String? ?? 'PENDING',
      roles: (json['roles'] as List?)?.map((e) => e as String).toList() ?? [],
      is_publisher_ban: json['is_publisher_ban'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        first_name,
        last_name,
        email,
        is_admin,
        dp_url,
        cover_image_url,
        is_disabled,
        is_verified,
        display_name,
        two_factor_auth_enable,
        bio,
        is_kba_enabled,
        is_secured,
        tooltip,
        timezone,
        timezone_offset,
        timezone_locale,
        avatar_id,
        is_publisher,
        is_publisher_approved,
        isOrganization,
        is_authorized,
        is_publisher_blocked,
        is_user_ban,
        is_user_blocked,
        user_ban_reason,
        user_blocked_reason,
        publisher_blocked_reason,
        applied_for_publisher,
        logged_in_as,
        company_detail_added,
        joined_as_user_on,
        joined_as_publisher_on,
        company_details,
        publisher_request_status,
        roles,
        is_publisher_ban,
      ];
}

class SocialProfile extends Equatable {
  final String user_id;
  final String? instagram_profile;
  final String? discord_profile;
  final String? twitter_profile;
  final String? website;
  final String? youtube;
  final String? google;
  final String? meta;

  const SocialProfile({
    required this.user_id,
    this.instagram_profile,
    this.discord_profile,
    this.twitter_profile,
    this.website,
    this.youtube,
    this.google,
    this.meta,
  });

  factory SocialProfile.fromJson(Map<String, dynamic> json) {
    return SocialProfile(
      user_id: json['user_id'] as String,
      instagram_profile: json['instagram_profile'] as String?,
      discord_profile: json['discord_profile'] as String?,
      twitter_profile: json['twitter_profile'] as String?,
      website: json['website'] as String?,
      youtube: json['youtube'] as String?,
      google: json['google'] as String?,
      meta: json['meta'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        user_id,
        instagram_profile,
        discord_profile,
        twitter_profile,
        website,
        youtube,
        google,
        meta,
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
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
      social: SocialProfile.fromJson(json['social'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [user, social];
}
