import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/game_page.dart';
import 'package:phynd_app/presentation/screens/home_page.dart';
import 'package:phynd_app/presentation/screens/login_page.dart';
import 'package:phynd_app/presentation/screens/player_profile_page.dart';
import 'package:phynd_app/presentation/screens/publisher_profile_page.dart';
import 'package:phynd_app/presentation/screens/quest_page.dart';
import 'package:phynd_app/presentation/screens/rainway_screen.dart';
import 'package:phynd_app/presentation/screens/registration_page.dart';
import 'package:phynd_app/presentation/screens/search_page.dart';
import 'package:phynd_app/presentation/screens/support_page.dart';
import 'package:phynd_app/presentation/screens/terms_and_conditions_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String game = '/game';
  static const String playerProfile = '/player-profile';
  static const String publisherProfile = '/publisher-profile';
  static const String search = '/search';
  static const String quest = '/quest';
  static const String support = '/support';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String rainwayGame = '/rainway-game';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case game:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => GamePage(gameSlug: args),
          );
        }
        return _errorRoute("Missing or invalid gameSlug");
      case playerProfile:
        return MaterialPageRoute(builder: (_) => const PlayerProfilePage());
      case publisherProfile:
        return MaterialPageRoute(builder: (_) => const PublisherProfilePage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case quest:
        return MaterialPageRoute(builder: (_) => const QuestPage());
      case support:
        return MaterialPageRoute(builder: (_) => const SupportPage());
      case rainwayGame:
        return MaterialPageRoute(builder: (_) => const RainwayPage());
      case termsAndConditions:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionsPage());
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
