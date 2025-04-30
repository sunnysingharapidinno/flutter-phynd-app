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

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'description': description,
      'media_type': mediaType.toShortString(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
    };
  }
}

class Platform {
  final String? imageUrl;
  final String? name;

  Platform({
    this.imageUrl,
    this.name,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      imageUrl: json['image_url'],
      name: json['name'],
    );
  }

  Map<String, String?> toMap() {
    return {
      'image_url': imageUrl,
      'name': name,
    };
  }
}

class Controller {
  final String? imageUrl;
  final String? name;

  Controller({
    this.imageUrl,
    this.name,
  });

  factory Controller.fromJson(Map<String, dynamic> json) {
    return Controller(
      imageUrl: json['image_url'],
      name: json['name'],
    );
  }

  Map<String, String?> toMap() {
    return {
      'image_url': imageUrl,
      'name': name,
    };
  }
}

class GameDetails {
  final String gameSlug;
  final String gameTitle;
  final String shortBio;
  final List<String> developers;
  final bool isBrowserBasedGame;
  final String? downloadUrl;
  final String? launcherUrl;
  final int releaseDate;
  final int? startDate;
  final int? endDate;
  final bool isBlockchainSupported;
  final String? blockchainPlatform;
  final List<String> genre;
  final List<String> subGenre;
  final bool adSupported;
  final bool contentRating;
  final bool ageRestricted;
  final String? cost;
  final int? rentalDuration;
  final bool syndicated;
  final String? websiteUrl;
  final String? twitterLink;
  final String? discordLink;
  final String? whitePaperLink;
  final String? telegramLink;
  final List<String> languageSupported;
  final List<String> modes;
  final List<Platform> platforms;
  final List<Controller> controllers;
  final List<String> browserSupport;
  final List<String> tags;
  final String? storageRequirements;
  final String? ramRequirements;
  final String? processorRequirements;
  final String? osRequirements;
  final List<GameOverview> gameMedia;
  final List<GameScreenshot> gameScreenshots;
  final List<String> gamePlayModes;
  final bool inAppPurchases;
  final bool isGameFeatured;
  final bool isFromVerifiedPublisher;
  final List<String> gameFranchise;
  final bool iframable;
  final String? publisherId;
  final String? publisherDisplayName;
  final String? publisherType;
  final String? parentCompanyId;
  final String? parentCompanyName;
  final String? parentCompanyDisplayName;
  final String? parentCompanyType;
  final String? esrbRatingImgUrl;
  final String? pegiRatingImgUrl;
  final String? rainwayGameId;

  GameDetails({
    required this.gameSlug,
    required this.gameTitle,
    required this.shortBio,
    required this.developers,
    required this.isBrowserBasedGame,
    this.downloadUrl,
    this.launcherUrl,
    required this.releaseDate,
    this.startDate,
    this.endDate,
    required this.isBlockchainSupported,
    this.blockchainPlatform,
    required this.genre,
    required this.subGenre,
    required this.adSupported,
    required this.contentRating,
    required this.ageRestricted,
    this.cost,
    this.rentalDuration,
    required this.syndicated,
    this.websiteUrl,
    this.twitterLink,
    this.discordLink,
    this.whitePaperLink,
    this.telegramLink,
    required this.languageSupported,
    required this.modes,
    required this.platforms,
    required this.controllers,
    required this.browserSupport,
    required this.tags,
    this.storageRequirements,
    this.ramRequirements,
    this.processorRequirements,
    this.osRequirements,
    required this.gameMedia,
    required this.gameScreenshots,
    required this.gamePlayModes,
    required this.inAppPurchases,
    required this.isGameFeatured,
    required this.isFromVerifiedPublisher,
    required this.gameFranchise,
    required this.iframable,
    this.publisherId,
    this.publisherDisplayName,
    this.publisherType,
    this.parentCompanyId,
    this.parentCompanyName,
    this.parentCompanyDisplayName,
    this.parentCompanyType,
    this.esrbRatingImgUrl,
    this.pegiRatingImgUrl,
    this.rainwayGameId,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      gameSlug: json['game_slug'] ?? '',
      gameTitle: json['game_title'] ?? '',
      shortBio: json['short_bio'] ?? '',
      developers: List<String>.from(
          (json['developers'] ?? []).where((e) => e != null) ?? []),
      isBrowserBasedGame: json['is_browser_based_game'] ?? false,
      downloadUrl: json['download_url'],
      launcherUrl: json['launcher_url'],
      releaseDate: json['release_date'] ?? 0,
      startDate: json['start_date'],
      endDate: json['end_date'],
      isBlockchainSupported: json['is_blockchain_supported'] ?? false,
      blockchainPlatform: json['blockchain_platform'],
      genre: List<String>.from(json['genre'] ?? []),
      subGenre: List<String>.from(json['sub_genre'] ?? []),
      adSupported: json['ad_supported'] ?? false,
      contentRating: json['content_rating'] ?? false,
      ageRestricted: json['age_restricted'] ?? false,
      cost: json['cost']?.toString(),
      rentalDuration: json['rental_duration'],
      syndicated: json['syndicated'] ?? false,
      websiteUrl: json['website_url'],
      twitterLink: json['twitter_link'],
      discordLink: json['discord_link'],
      whitePaperLink: json['white_paper_link'],
      telegramLink: json['telegram_link'],
      languageSupported: List<String>.from(json['language_supported'] ?? []),
      modes: List<String>.from(json['modes'] ?? []),
      platforms: (json['platforms'] as List? ?? [])
          .map((p) => Platform.fromJson(p))
          .toList(),
      controllers: (json['controllers'] as List? ?? [])
          .map((c) => Controller.fromJson(c))
          .toList(),
      browserSupport: List<String>.from(json['browser_support'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      storageRequirements: json['storage_requirements'],
      ramRequirements: json['ram_requirements'],
      processorRequirements: json['processor_requirements'],
      osRequirements: json['os_requirements'],
      gameMedia: (json['game_media'] as List? ?? [])
          .map((x) => GameOverview.fromJson(x))
          .toList(),
      gameScreenshots: (json['game_screenshots'] as List? ?? [])
          .map((x) => GameScreenshot.fromJson(x))
          .toList(),
      gamePlayModes: List<String>.from(json['game_play_modes'] ?? []),
      inAppPurchases: json['in_app_purchases'] ?? false,
      isGameFeatured: json['is_game_featured'] ?? false,
      isFromVerifiedPublisher: json['is_from_verified_publisher'] ?? false,
      gameFranchise: List<String>.from(json['game_franchise'] ?? []),
      iframable: json['iframable'] ?? false,
      publisherId: json['publisher_id'],
      publisherDisplayName: json['publisher_display_name'],
      publisherType: json['publisher_type'],
      parentCompanyId: json['parent_company_id'],
      parentCompanyName: json['parent_company_name'],
      parentCompanyDisplayName: json['parent_company_display_name'],
      parentCompanyType: json['parent_company_type'],
      esrbRatingImgUrl: json['esrb_rating_img_url'],
      pegiRatingImgUrl: json['pegi_rating_img_url'],
      rainwayGameId: json['rainway_game_id'],
    );
  }
}

class Game {
  final String gameSlug;
  final String gameTitle;
  final String shortBio;
  final List<String> developers;
  final bool? isBrowserBasedGame;
  final String? downloadUrl;
  final String? launcherUrl;
  final int releaseDate;
  final int? startDate;
  final int? endDate;
  final bool? isBlockchainSupported;
  final String? blockchainPlatform;
  final List<String> genre;
  final List<String> subGenre;
  final bool? adSupported;
  final bool? contentRating;
  final bool? ageRestricted;
  final String? cost;
  final int? rentalDuration;
  final bool? syndicated;
  final String? websiteUrl;
  final String? twitterLink;
  final String? discordLink;
  final String? whitePaperLink;
  final String? telegramLink;
  final List<String> languageSupported;
  final List<String> modes;
  final List<Platform> platforms;
  final List<Controller> controllers;
  final List<String> browserSupport;
  final List<String> tags;
  final String? storageRequirements;
  final String? ramRequirements;
  final String? processorRequirements;
  final String? osRequirements;
  final List<GameOverview> gameMedia;
  final List<GameScreenshot> gameScreenshots;
  final List<String>? gamePlayModes;
  final bool? inAppPurchases;
  final bool? isGameFeatured;
  final bool? isFromVerifiedPublisher;
  final List<String>? gameFranchise;
  final bool? iframable;
  final String? publisherId;
  final String? publisherDisplayName;
  final String? publisherType;
  final String? parentCompanyId;
  final String? parentCompanyName;
  final String? parentCompanyDisplayName;
  final String? parentCompanyType;
  final String? esrbRatingImgUrl;
  final String? pegiRatingImgUrl;
  final String? rainwayGameId;

  Game({
    required this.gameSlug,
    required this.gameTitle,
    required this.shortBio,
    required this.developers,
    this.isBrowserBasedGame,
    this.downloadUrl,
    this.launcherUrl,
    required this.releaseDate,
    this.startDate,
    this.endDate,
    this.isBlockchainSupported,
    this.blockchainPlatform,
    required this.genre,
    required this.subGenre,
    this.adSupported,
    this.contentRating,
    this.ageRestricted,
    this.cost,
    this.rentalDuration,
    this.syndicated,
    this.websiteUrl,
    this.twitterLink,
    this.discordLink,
    this.whitePaperLink,
    this.telegramLink,
    required this.languageSupported,
    required this.modes,
    required this.platforms,
    required this.controllers,
    required this.browserSupport,
    required this.tags,
    this.storageRequirements,
    this.ramRequirements,
    this.processorRequirements,
    this.osRequirements,
    required this.gameMedia,
    required this.gameScreenshots,
    this.gamePlayModes,
    this.inAppPurchases,
    this.isGameFeatured,
    this.isFromVerifiedPublisher,
    this.gameFranchise,
    this.iframable,
    this.publisherId,
    this.publisherDisplayName,
    this.publisherType,
    this.parentCompanyId,
    this.parentCompanyName,
    this.parentCompanyDisplayName,
    this.parentCompanyType,
    this.esrbRatingImgUrl,
    this.pegiRatingImgUrl,
    this.rainwayGameId,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameSlug: json['game_slug'] ?? '',
      gameTitle: json['game_title'] ?? '',
      shortBio: json['short_bio'] ?? '',
      developers: List<String>.from(json['developers'] ?? []),
      isBrowserBasedGame: json['is_browser_based_game'],
      downloadUrl: json['download_url'],
      launcherUrl: json['launcher_url'],
      releaseDate: json['release_date'] ?? 0,
      startDate: json['start_date'],
      endDate: json['end_date'],
      isBlockchainSupported: json['is_blockchain_supported'],
      blockchainPlatform: json['blockchain_platform'],
      genre: List<String>.from(json['genre'] ?? []),
      subGenre: List<String>.from(json['sub_genre'] ?? []),
      adSupported: json['ad_supported'],
      contentRating: json['content_rating'],
      ageRestricted: json['age_restricted'],
      cost: json['cost']?.toString(),
      rentalDuration: json['rental_duration'],
      syndicated: json['syndicated'],
      websiteUrl: json['website_url'],
      twitterLink: json['twitter_link'],
      discordLink: json['discord_link'],
      whitePaperLink: json['white_paper_link'],
      telegramLink: json['telegram_link'],
      languageSupported: List<String>.from(json['language_supported'] ?? []),
      modes: List<String>.from(json['modes'] ?? []),
      platforms: (json['platforms'] as List? ?? [])
          .map((p) => Platform.fromJson(p))
          .toList(),
      controllers: (json['controllers'] as List? ?? [])
          .map((c) => Controller.fromJson(c))
          .toList(),
      browserSupport: List<String>.from(json['browser_support'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      storageRequirements: json['storage_requirements'],
      ramRequirements: json['ram_requirements'],
      processorRequirements: json['processor_requirements'],
      osRequirements: json['os_requirements'],
      gameMedia: (json['game_media'] as List? ?? [])
          .map((x) => GameOverview.fromJson(x))
          .toList(),
      gameScreenshots: (json['game_screenshots'] as List? ?? [])
          .map((x) => GameScreenshot.fromJson(x))
          .toList(),
      gamePlayModes: json['game_play_modes'] != null
          ? List<String>.from(json['game_play_modes'])
          : null,
      inAppPurchases: json['in_app_purchases'],
      isGameFeatured: json['is_game_featured'],
      isFromVerifiedPublisher: json['is_from_verified_publisher'],
      gameFranchise: json['game_franchise'] != null
          ? List<String>.from(json['game_franchise'])
          : null,
      iframable: json['iframable'],
      publisherId: json['publisher_id'],
      publisherDisplayName: json['publisher_display_name'],
      publisherType: json['publisher_type'],
      parentCompanyId: json['parent_company_id'],
      parentCompanyName: json['parent_company_name'],
      parentCompanyDisplayName: json['parent_company_display_name'],
      parentCompanyType: json['parent_company_type'],
      esrbRatingImgUrl: json['esrb_rating_img_url'],
      pegiRatingImgUrl: json['pegi_rating_img_url'],
      rainwayGameId: json['rainway_game_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_slug': gameSlug,
      'game_title': gameTitle,
      'short_bio': shortBio,
      'developers': developers,
      'is_browser_based_game': isBrowserBasedGame,
      'download_url': downloadUrl,
      'launcher_url': launcherUrl,
      'release_date': releaseDate,
      'start_date': startDate,
      'end_date': endDate,
      'is_blockchain_supported': isBlockchainSupported,
      'blockchain_platform': blockchainPlatform,
      'genre': genre,
      'sub_genre': subGenre,
      'ad_supported': adSupported,
      'content_rating': contentRating,
      'age_restricted': ageRestricted,
      'cost': cost,
      'rental_duration': rentalDuration,
      'syndicated': syndicated,
      'website_url': websiteUrl,
      'twitter_link': twitterLink,
      'discord_link': discordLink,
      'white_paper_link': whitePaperLink,
      'telegram_link': telegramLink,
      'language_supported': languageSupported,
      'modes': modes,
      'platforms': platforms.map((p) => p.toMap()).toList(),
      'controllers': controllers.map((c) => c.toMap()).toList(),
      'browser_support': browserSupport,
      'tags': tags,
      'storage_requirements': storageRequirements,
      'ram_requirements': ramRequirements,
      'processor_requirements': processorRequirements,
      'os_requirements': osRequirements,
      'game_media': gameMedia.map((m) => m.toJson()).toList(),
      'game_screenshots': gameScreenshots.map((s) => s.toJson()).toList(),
      'game_play_modes': gamePlayModes,
      'in_app_purchases': inAppPurchases,
      'is_game_featured': isGameFeatured,
      'is_from_verified_publisher': isFromVerifiedPublisher,
      'game_franchise': gameFranchise,
      'iframable': iframable,
      'publisher_id': publisherId,
      'publisher_display_name': publisherDisplayName,
      'publisher_type': publisherType,
      'parent_company_id': parentCompanyId,
      'parent_company_name': parentCompanyName,
      'parent_company_display_name': parentCompanyDisplayName,
      'parent_company_type': parentCompanyType,
      'esrb_rating_img_url': esrbRatingImgUrl,
      'pegi_rating_img_url': pegiRatingImgUrl,
      'rainway_game_id': rainwayGameId,
    };
  }
}
