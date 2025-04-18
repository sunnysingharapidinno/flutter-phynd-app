import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Future<void> load() async {
    await dotenv.load(); // Loads the .env file
  }

  // API Base URLs

  static String get userBaseUrl =>
      dotenv.env['FLUTTER_APP_USER_BASE_URL'] ?? '';
  static String get adminBaseUrl =>
      dotenv.env['FLUTTER_APP_ADMIN_BASE_URL'] ?? '';
  static String get gameBaseUrl =>
      dotenv.env['FLUTTER_APP_GAME_BASE_URL'] ?? '';
  static String get marketplaceBaseUrl =>
      dotenv.env['FLUTTER_APP_MARKETPLACE_BASE_URL'] ?? '';
  static String get launchpadBaseUrl =>
      dotenv.env['FLUTTER_APP_LAUNCHPAD_BASE_URL'] ?? '';
  static String get questBaseUrl =>
      dotenv.env['FLUTTER_APP_QUEST_BASE_URL'] ?? '';
  static String get questWebSocketBaseUrl =>
      dotenv.env['FLUTTER_APP_QUEST_WEB_SOCKET_BASE_URL'] ?? '';
  static String get subscriptionBaseUrl =>
      dotenv.env['FLUTTER_APP_SUBSCRIPTION_BASE_URL'] ?? '';
  static String get userSseBaseUrl =>
      dotenv.env['FLUTTER_APP_USER_SSE_BASE_URL'] ?? '';
  static String get webCarouselBaseUrl =>
      dotenv.env['FLUTTER_APP_WEB_CAROUSEL_BASE_URL'] ?? '';
  static String get userWebSocketBaseUrl =>
      dotenv.env['FLUTTER_APP_USER_WEBSOCKET_BASE_URL'] ?? '';
}
