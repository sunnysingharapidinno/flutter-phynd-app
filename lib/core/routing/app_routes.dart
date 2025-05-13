import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/screens/game_interstitial.dart';
import 'package:phynd_app/presentation/screens/game_page.dart';
import 'package:phynd_app/presentation/screens/home_page.dart';
import 'package:phynd_app/presentation/screens/library_page/library_page.dart';
import 'package:phynd_app/presentation/screens/login_page.dart';
import 'package:phynd_app/presentation/screens/player_profile_page.dart';
import 'package:phynd_app/presentation/screens/publisher_profile_page.dart';
import 'package:phynd_app/presentation/screens/quest_details_page.dart';
import 'package:phynd_app/presentation/screens/quest_page.dart';
import 'package:phynd_app/presentation/screens/registration_page.dart';
import 'package:phynd_app/presentation/screens/search_page.dart';
import 'package:phynd_app/presentation/screens/support_page.dart';
import 'package:phynd_app/presentation/screens/terms_and_conditions_page.dart';
import 'package:phynd_app/presentation/screens/video_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String gameInterstitial = '/game-interstitial';
  static const String library = '/library';
  static const String friends = '/friends';
  static const String following = '/following';
  static const String account = '/account';
  static const String search = '/search';
  static const String video = '/video';
  static const String playerProfile = '/player-profile';
  static const String publisherProfile = '/publisher-profile';
  static const String login = '/sign-up';

  //-------------------------------- below pages are not confirmed yet --------------------------------

  static const String registration = '/registration';
  static const String game = '/game';
  static const String quest = '/quest';
  static const String questDetails = '/quest-details';
  static const String support = '/support';
  static const String termsAndConditions = '/terms-and-conditions';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    Widget wrap(Widget child) => BaseLayout(child: child);

    switch (settings.name) {
      // case home:
      //   return MaterialPageRoute(builder: (_) => wrap(const HomePage()));
      case gameInterstitial:
        return MaterialPageRoute(
            builder: (_) => wrap(const GameInterstitialPage()));
      case login:
        return MaterialPageRoute(builder: (_) => wrap(const LoginPage()));
      case registration:
        return MaterialPageRoute(
            builder: (_) => wrap(const RegistrationScreen()));
      case game:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => wrap(GamePage(gameSlug: args)),
          );
        }
        return _errorRoute("Missing or invalid gameSlug");

      case home:
        return MaterialPageRoute(
          builder: (_) => wrap(PlayerProfilePage(userId: args as String?)),
        );

      case publisherProfile:
        return MaterialPageRoute(
            builder: (_) => wrap(const PublisherProfilePage()));
      case search:
        return MaterialPageRoute(builder: (_) => wrap(const SearchPage()));
      case quest:
        return MaterialPageRoute(builder: (_) => wrap(const QuestPage()));
      case questDetails:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => wrap(QuestDetailsPage(questId: args)),
          );
        }
        return _errorRoute("Missing or invalid questId");

      case support:
        return MaterialPageRoute(builder: (_) => wrap(const SupportPage()));
      case video:
        return MaterialPageRoute(builder: (_) => wrap(const VideoPage()));
      case termsAndConditions:
        return MaterialPageRoute(
            builder: (_) => wrap(const TermsAndConditionsPage()));
      case library:
        return MaterialPageRoute(builder: (_) => wrap(const LibraryPage()));
      default:
        return _errorRoute("Route not found");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(message)),
      ),
    );
  }
}
