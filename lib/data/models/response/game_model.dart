import 'package:flutter/foundation.dart';

enum GameOvMediaType {
  image,
  video;

  factory GameOvMediaType.fromString(String value) {
    return GameOvMediaType.values.firstWhere(
      (e) => describeEnum(e) == value,
      orElse: () => GameOvMediaType.image,
    );
  }

  String toShortString() => describeEnum(this);
}

class GameOverview {
  final String url;
  final String title;
  final String description;
  final GameOvMediaType mediaType;

  GameOverview({
    required this.url,
    required this.title,
    required this.description,
    required this.mediaType,
  });

  factory GameOverview.fromJson(Map<String, dynamic> json) {
    return GameOverview(
      url: json['url'],
      title: json['title'],
      description: json['description'],
      mediaType: GameOvMediaType.fromString(json['media_type']),
    );
  }
}

class GameScreenshot {
  final String url;
  final String? title;

  GameScreenshot({
    required this.url,
    this.title,
  });

  factory GameScreenshot.fromJson(Map<String, dynamic> json) {
    return GameScreenshot(
      url: json['url'],
      title: json['title'],
    );
  }
}

class GameDetails {
  final String gameSlug;
  final String gameTitle;
  final String shortBio;
  final List<String> developers;
  final bool isBrowserBasedGame;
  final String downloadUrl;
  final String? launcherUrl;
  final int releaseDate;
  final String publisherDisplayNameSlug;
  final int startDate;
  final int endDate;
  final bool isBlockchainSupported;
  final String blockchainPlatform;
  final List<String> genre;
  final bool adSupported;
  final bool contentRating;
  final bool ageRestricted;
  final String cost;
  final int rentalDuration;
  final bool syndicated;
  final String? websiteUrl;
  final String? twitterLink;
  final String? discordLink;
  final String? whitePaperLink;
  final String? telegramLink;
  final List<String> languageSupported;
  final List<String> modes;
  final List<Map<String, String?>> platforms;
  final List<String?> browserSupport;
  final List<String?> tags;
  final String storageRequirements;
  final String ramRequirements;
  final String processorRequirements;
  final String osRequirements;
  final List<GameOverview> gameMedia;
  final List<String>? gamePlayModes;
  final bool? inAppPurchases;
  final List<GameScreenshot> gameScreenshots;
  final bool? isGameFeatured;
  final bool? isFromVerifiedPublisher;
  final bool? iframable;
  final List<String>? gameFranchise;
  final String? publisherDisplayName;
  final String? publisherId;

  GameDetails({
    required this.gameSlug,
    required this.gameTitle,
    required this.shortBio,
    required this.developers,
    required this.isBrowserBasedGame,
    required this.downloadUrl,
    this.launcherUrl,
    required this.releaseDate,
    required this.publisherDisplayNameSlug,
    required this.startDate,
    required this.endDate,
    required this.isBlockchainSupported,
    required this.blockchainPlatform,
    required this.genre,
    required this.adSupported,
    required this.contentRating,
    required this.ageRestricted,
    required this.cost,
    required this.rentalDuration,
    required this.syndicated,
    this.websiteUrl,
    required this.twitterLink,
    required this.discordLink,
    required this.whitePaperLink,
    required this.telegramLink,
    required this.languageSupported,
    required this.modes,
    required this.platforms,
    required this.browserSupport,
    required this.tags,
    required this.storageRequirements,
    required this.ramRequirements,
    required this.processorRequirements,
    required this.osRequirements,
    required this.gameMedia,
    this.gamePlayModes,
    this.inAppPurchases,
    required this.gameScreenshots,
    this.isGameFeatured,
    this.isFromVerifiedPublisher,
    this.iframable,
    this.gameFranchise,
    this.publisherDisplayName,
    this.publisherId,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      gameSlug: json['game_slug'],
      gameTitle: json['game_title'],
      shortBio: json['short_bio'],
      developers: List<String>.from(json['developers']),
      isBrowserBasedGame: json['is_browser_based_game'],
      downloadUrl: json['download_url'],
      launcherUrl: json['launcher_url'],
      releaseDate: json['release_date'],
      publisherDisplayNameSlug: json['publisher_display_name_slug'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      isBlockchainSupported: json['is_blockchain_supported'],
      blockchainPlatform: json['blockchain_platform'],
      genre: List<String>.from(json['genre']),
      adSupported: json['ad_supported'],
      contentRating: json['content_rating'],
      ageRestricted: json['age_restricted'],
      cost: json['cost'],
      rentalDuration: json['rental_duration'],
      syndicated: json['syndicated'],
      websiteUrl: json['website_url'],
      twitterLink: json['twitter_link']?.toString(),
      discordLink: json['discord_link']?.toString(),
      whitePaperLink: json['white_paper_link']?.toString(),
      telegramLink: json['telegram_link']?.toString(),
      languageSupported: List<String>.from(json['language_supported']),
      modes: List<String>.from(json['modes']),
      // platforms: List<Map<String, String?>>.from(
      //   (json['platforms'] as List).map((p) => {
      //         'image_url': p['image_url'],
      //         'name': p['name'],
      //       }),
      // ),
      platforms: List<Map<String, String?>>.from(
        (json['platforms'] as List)
            .map((p) => {
                  'image_url': p['image_url'] as String?,
                  'name': p['name'] as String?,
                })
            .map((e) => e.cast<String, String?>()),
      ),
      browserSupport: List<String?>.from(json['browser_support']),
      tags: List<String?>.from(json['tags']),
      storageRequirements: json['storage_requirements'],
      ramRequirements: json['ram_requirements'],
      processorRequirements: json['processor_requirements'],
      osRequirements: json['os_requirements'],
      gameMedia: List<GameOverview>.from(
        json['game_media'].map((x) => GameOverview.fromJson(x)),
      ),
      gamePlayModes: json['game_play_modes'] != null
          ? List<String>.from(json['game_play_modes'])
          : null,
      inAppPurchases: json['in_app_purchases'],
      gameScreenshots: List<GameScreenshot>.from(
        json['game_screenshots'].map((x) => GameScreenshot.fromJson(x)),
      ),
      isGameFeatured: json['is_game_featured'],
      isFromVerifiedPublisher: json['is_from_verified_publisher'],
      iframable: json['iframable'],
      gameFranchise: json['game_franchise'] != null
          ? List<String>.from(json['game_franchise'])
          : null,
      publisherDisplayName: json['publisher_display_name'],
      publisherId: json['publisher_id'],
    );
  }
}
