class Game {
  final List<String>? category;
  final String? companyImage;
  final String? companyName;
  final String? companyWebsite;
  final String? contractId;
  final String? downloadUrl;
  final String? esrbRatingImgUrl;
  final int? firstReleaseDate;
  final String gameChain;
  final bool? iframable;
  final String? image;
  final bool? isBrowserBasedGame;
  final String? launcherUrl;
  final List<GameMarketplace>? marketplaces;
  final List<String>? mode;
  final String name;
  final List<String>? platform;
  final String? publisherDisplayName;
  final String? publisherFirstName;
  final String? publisherId;
  final String? publisherImgUrl;
  final String? rainwayGameId;
  final String slug;
  final String? summary;

  Game({
    this.category,
    this.companyImage,
    this.companyName,
    this.companyWebsite,
    this.contractId,
    this.downloadUrl,
    this.esrbRatingImgUrl,
    this.firstReleaseDate,
    required this.gameChain,
    this.iframable,
    this.image,
    this.isBrowserBasedGame,
    this.launcherUrl,
    this.marketplaces,
    this.mode,
    required this.name,
    this.platform,
    this.publisherDisplayName,
    this.publisherFirstName,
    this.publisherId,
    this.publisherImgUrl,
    this.rainwayGameId,
    required this.slug,
    this.summary,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      // Filter out null values in arrays
      category: json['category'] != null
          ? List<String>.from(
              (json['category'] as List).where((x) => x != null))
          : null,

      companyImage: json['company_image'] as String?,
      companyName: json['company_name'] as String?,
      companyWebsite: json['company_website'] as String?,
      contractId: json['contract_id'] as String?,
      downloadUrl: json['download_url'] as String?,
      esrbRatingImgUrl: json['esrb_rating_img_url'] as String?,
      firstReleaseDate: json['first_release_date'] as int?,
      gameChain: json['game_chain'] as String,
      iframable: json['iframable'] as bool?,
      image: json['image'] as String?,
      isBrowserBasedGame: json['is_browser_based_game'] as bool?,
      launcherUrl: json['launcher_url'] as String?,

      marketplaces: json['marketplaces'] != null
          ? List<GameMarketplace>.from((json['marketplaces'] as List)
              .map((x) => GameMarketplace.fromJson(x as Map<String, dynamic>)))
          : null,

      // Filter out null values in arrays
      mode: json['mode'] != null
          ? List<String>.from((json['mode'] as List).where((x) => x != null))
          : null,

      name: json['name'] as String,

      // Filter out null values in platform array
      platform: json['platform'] != null
          ? List<String>.from(
              (json['platform'] as List).where((x) => x != null))
          : null,

      publisherDisplayName: json['publisher_display_name'] as String?,
      publisherFirstName: json['publisher_first_name'] as String?,
      publisherId: json['publisher_id'] as String?,
      publisherImgUrl: json['publisher_img_url'] as String?,
      rainwayGameId: json['rainway_game_id'] as String?,
      slug: json['slug'] as String,
      summary: json['summary'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'company_image': companyImage,
      'company_name': companyName,
      'company_website': companyWebsite,
      'contract_id': contractId,
      'download_url': downloadUrl,
      'esrb_rating_img_url': esrbRatingImgUrl,
      'first_release_date': firstReleaseDate,
      'game_chain': gameChain,
      'iframable': iframable,
      'image': image,
      'is_browser_based_game': isBrowserBasedGame,
      'launcher_url': launcherUrl,
      'marketplaces': marketplaces?.map((x) => x.toJson()).toList(),
      'mode': mode,
      'name': name,
      'platform': platform,
      'publisher_display_name': publisherDisplayName,
      'publisher_first_name': publisherFirstName,
      'publisher_id': publisherId,
      'publisher_img_url': publisherImgUrl,
      'rainway_game_id': rainwayGameId,
      'slug': slug,
      'summary': summary,
    };
  }
}

class GameMarketplace {
  final String domain;
  final String imageUrl;
  final String name;

  GameMarketplace({
    required this.domain,
    required this.imageUrl,
    required this.name,
  });

  factory GameMarketplace.fromJson(Map<String, dynamic> json) {
    return GameMarketplace(
      domain: json['domain'] as String,
      imageUrl: json['image_url'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'image_url': imageUrl,
      'name': name,
    };
  }
}
