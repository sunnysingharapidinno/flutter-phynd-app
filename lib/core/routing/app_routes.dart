import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/screens/game_page.dart';
import 'package:phynd_app/presentation/screens/home_page.dart';
import 'package:phynd_app/presentation/screens/login_page.dart';
import 'package:phynd_app/presentation/screens/player_profile_page.dart';
import 'package:phynd_app/presentation/screens/publisher_profile_page.dart';
import 'package:phynd_app/presentation/screens/quest_page.dart';
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

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const HomePage(),
        login: (context) => const LoginPage(),
        registration: (context) => const RegistrationScreen(),
        game: (context) => const GamePage(),
        playerProfile: (context) => const PlayerProfilePage(),
        publisherProfile: (context) => const PublisherProfilePage(),
        search: (context) => const SearchPage(),
        quest: (context) => const QuestPage(),
        support: (context) => const SupportPage(),
        termsAndConditions: (context) => const TermsAndConditionsPage(),
      };
}
