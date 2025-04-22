import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/profile/profile_header.dart';
import 'package:phynd_app/presentation/widgets/profile/stat_counter.dart';
import 'package:phynd_app/presentation/widgets/profile/game_card.dart';

class PlayerProfilePage extends StatefulWidget {
  const PlayerProfilePage({super.key});

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  final UserService _userService = UserService();
  Profile? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserDetails('f1b11158-fd52-45db-b74b-ea62d6a9c3ea');
  }

  Future<void> _getUserDetails(String userId) async {
    try {
      final profile = await _userService.getUserById(userId: userId);
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = _userProfile != null
        ? "${_userProfile!.user.first_name} ${_userProfile!.user.last_name}"
        : "User";

    print('User Profile: ${_userProfile?.user}');

    return BaseLayout(
      title: 'Player Profile',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header with Banner
                ProfileHeader(
                  username: displayName,
                  isOnline: true,
                  avatar:
                      _userProfile?.user.dp_url ?? 'assets/images/avatar.png',
                  bannerImage: 'assets/images/profile_banner.png',
                ),

                // Stats Row
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      StatCounter(label: 'Followers', value: '0'),
                      StatCounter(label: 'Following', value: '0'),
                      StatCounter(label: 'PHYND Coins', value: '22'),
                      StatCounter(label: 'Badges', value: '0'),
                      StatCounter(label: 'Clips', value: '0'),
                    ],
                  ),
                ),

                // Favorite Games Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favorite Games',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .extension<AppTheme>()!
                                .get('text'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: const [
                                GameCard(
                                  number: 1,
                                  name: 'Grit',
                                  image: 'assets/images/games/grit.png',
                                ),
                                SizedBox(width: 12),
                                GameCard(
                                  number: 2,
                                  name: 'Brawl Stars',
                                  image: 'assets/images/games/brawl_stars.png',
                                ),
                                SizedBox(width: 12),
                                GameCard(
                                  number: 3,
                                  name: 'Fortnite',
                                  image: 'assets/images/games/fortnite.png',
                                ),
                                SizedBox(width: 12),
                                GameCard(
                                  number: 4,
                                  name: 'Neon Racers',
                                  image: 'assets/images/games/neon_racers.png',
                                ),
                                SizedBox(width: 12),
                                GameCard(
                                  number: 5,
                                  name: 'Mario Kart',
                                  image: 'assets/images/games/mario_kart.png',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
