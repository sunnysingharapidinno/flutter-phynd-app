import 'package:phynd_app/config/env.dart';

enum ApiBaseUrl {
  flutterAppUserBaseUrl,
  flutterAppAdminBaseUrl,
  flutterAppGameBaseUrl,
  flutterAppMarketplaceBaseUrl,
  flutterAppLaunchpadBaseUrl,
  flutterAppQuestBaseUrl,
  flutterAppQuestWebSocketBaseUrl,
  flutterAppSubscriptionBaseUrl,
  flutterAppUserSseBaseUrl,
  flutterAppWebCarouselBaseUrl,
  flutterAppUserWebSocketBaseUrl;

  // Method to retrieve the URL for each enum value from .env file
  String get url {
    switch (this) {
      case ApiBaseUrl.flutterAppUserBaseUrl:
        return Env.userBaseUrl;
      case ApiBaseUrl.flutterAppAdminBaseUrl:
        return Env.adminBaseUrl;
      case ApiBaseUrl.flutterAppGameBaseUrl:
        return Env.gameBaseUrl;
      case ApiBaseUrl.flutterAppMarketplaceBaseUrl:
        return Env.marketplaceBaseUrl;
      case ApiBaseUrl.flutterAppLaunchpadBaseUrl:
        return Env.launchpadBaseUrl;
      case ApiBaseUrl.flutterAppQuestBaseUrl:
        return Env.questBaseUrl;
      case ApiBaseUrl.flutterAppQuestWebSocketBaseUrl:
        return Env.questWebSocketBaseUrl;
      case ApiBaseUrl.flutterAppSubscriptionBaseUrl:
        return Env.subscriptionBaseUrl;
      case ApiBaseUrl.flutterAppUserSseBaseUrl:
        return Env.userSseBaseUrl;
      case ApiBaseUrl.flutterAppWebCarouselBaseUrl:
        return Env.webCarouselBaseUrl;
      case ApiBaseUrl.flutterAppUserWebSocketBaseUrl:
        return Env.userWebSocketBaseUrl;
    }
  }
}
