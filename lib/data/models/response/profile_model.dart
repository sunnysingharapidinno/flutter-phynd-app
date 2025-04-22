class CompanyDetails {
  final String? id;
  final String? companyName;
  final String? companyMetaphone;
  final String? website;
  final String? about;
  final String? suffix;
  final String? createdAt;
  final String? modifiedAt;
  final String? createdBy;
  final String? image;
  final bool? isIndividual;
  final String? orgType;
  final String? parentId;

  const CompanyDetails({
    this.id,
    this.companyName,
    this.companyMetaphone,
    this.website,
    this.about,
    this.suffix,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.image,
    this.isIndividual,
    this.orgType,
    this.parentId,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      id: json['id'],
      companyName: json['company_name'],
      companyMetaphone: json['company_metaphone'],
      website: json['website'],
      about: json['about'],
      suffix: json['suffix'],
      createdAt: json['created_at'],
      modifiedAt: json['modified_at'],
      createdBy: json['created_by'],
      image: json['image'],
      isIndividual: json['is_individual'],
      orgType: json['org_type'],
      parentId: json['parent_id'],
    );
  }
}

class Social {
  final String? userId;
  final String? instagramProfile;
  final String? discordProfile;
  final String? twitterProfile;
  final String? website;
  final String? youtube;
  final String? google;
  final String? meta;

  const Social({
    this.userId,
    this.instagramProfile,
    this.discordProfile,
    this.twitterProfile,
    this.website,
    this.youtube,
    this.google,
    this.meta,
  });

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      userId: json['user_id'],
      instagramProfile: json['instagram_profile'],
      discordProfile: json['discord_profile'],
      twitterProfile: json['twitter_profile'],
      website: json['website'],
      youtube: json['youtube'],
      google: json['google'],
      meta: json['meta'],
    );
  }
}

class Profile {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? displayName;
  final String? timezone;
  final int? timezoneOffset;
  final String? timezoneLocale;
  final bool? isVerified;
  final bool? isDisabled;
  final bool? isAuthorized;
  final bool? isPublisher;
  final bool? isPublisherApproved;
  final bool? isOrganization;
  final bool? isSecured;
  final bool? isKbaEnabled;
  final bool? isUserBlocked;
  final bool? isUserBan;
  final bool? isPublisherBlocked;
  final String? userBanReason;
  final String? userBlockedReason;
  final String? publisherBlockedReason;
  final String? loggedInAs;
  final bool? tooltip;
  final String? joinedAsUserOn;
  final String? joinedAsPublisherOn;
  final bool? companyDetailAdded;
  final bool? appliedForPublisher;
  final String? publisherRequestStatus;
  final List<String>? roles;
  final CompanyDetails? companyDetails;
  final Social? social;

  const Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.displayName,
    this.timezone,
    this.timezoneOffset,
    this.timezoneLocale,
    this.isVerified,
    this.isDisabled,
    this.isAuthorized,
    this.isPublisher,
    this.isPublisherApproved,
    this.isOrganization,
    this.isSecured,
    this.isKbaEnabled,
    this.isUserBlocked,
    this.isUserBan,
    this.isPublisherBlocked,
    this.userBanReason,
    this.userBlockedReason,
    this.publisherBlockedReason,
    this.loggedInAs,
    this.tooltip,
    this.joinedAsUserOn,
    this.joinedAsPublisherOn,
    this.companyDetailAdded,
    this.appliedForPublisher,
    this.publisherRequestStatus,
    this.roles,
    this.companyDetails,
    this.social,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      displayName: json['display_name'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      timezoneLocale: json['timezone_locale'],
      isVerified: json['is_verified'],
      isDisabled: json['is_disabled'],
      isAuthorized: json['is_authorized'],
      isPublisher: json['is_publisher'],
      isPublisherApproved: json['is_publisher_approved'],
      isOrganization: json['isOrganization'],
      isSecured: json['is_secured'],
      isKbaEnabled: json['is_kba_enabled'],
      isUserBlocked: json['is_user_blocked'],
      isUserBan: json['is_user_ban'],
      isPublisherBlocked: json['is_publisher_blocked'],
      userBanReason: json['user_ban_reason'],
      userBlockedReason: json['user_blocked_reason'],
      publisherBlockedReason: json['publisher_blocked_reason'],
      loggedInAs: json['logged_in_as'],
      tooltip: json['tooltip'],
      joinedAsUserOn: json['joined_as_user_on'],
      joinedAsPublisherOn: json['joined_as_publisher_on'],
      companyDetailAdded: json['company_detail_added'],
      appliedForPublisher: json['applied_for_publisher'],
      publisherRequestStatus: json['publisher_request_status'],
      roles: (json['roles'] as List?)?.map((e) => e.toString()).toList(),
      companyDetails: json['company_details'] != null
          ? CompanyDetails.fromJson(json['company_details'])
          : null,
      social: json['social'] != null ? Social.fromJson(json['social']) : null,
    );
  }
}
