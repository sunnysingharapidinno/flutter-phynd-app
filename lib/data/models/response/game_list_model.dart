class Game {
  final List<String> category;
  final String image;
  final List<String> mode;
  final String name;
  final List<String> platform;
  final String slug;
  final String summary;
  final String gameChain;
  final List<GameMarketplace> marketplaces;
  final String? publisherImgUrl;
  final String? publisherFirstName;
  final String? publisherDisplayName;
  final dynamic firstReleaseDate; // can be String or int
  final bool? isBrowserBasedGame;
  final String? launcherUrl;
  final String? downloadUrl;
  final bool? iframable;

  Game({
    required this.category,
    required this.image,
    required this.mode,
    required this.name,
    required this.platform,
    required this.slug,
    required this.summary,
    required this.gameChain,
    required this.marketplaces,
    this.publisherImgUrl,
    this.publisherFirstName,
    this.publisherDisplayName,
    this.firstReleaseDate,
    this.isBrowserBasedGame,
    this.launcherUrl,
    this.downloadUrl,
    this.iframable,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      category: List<String>.from(json['category']),
      image: json['image'],
      mode: List<String>.from(json['mode']),
      name: json['name'],
      platform: List<String>.from(json['platform']),
      slug: json['slug'],
      summary: json['summary'],
      gameChain: json['game_chain'],
      marketplaces: (json['marketplaces'] as List)
          .map((e) => GameMarketplace.fromJson(e))
          .toList(),
      publisherImgUrl: json['publisher_img_url'],
      publisherFirstName: json['publisher_first_name'],
      publisherDisplayName: json['publisher_display_name'],
      firstReleaseDate: json['first_release_date'],
      isBrowserBasedGame: json['is_browser_based_game'],
      launcherUrl: json['launcher_url'],
      downloadUrl: json['download_url'],
      iframable: json['iframable'],
    );
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
      domain: json['domain'],
      imageUrl: json['image_url'],
      name: json['name'],
    );
  }
}
