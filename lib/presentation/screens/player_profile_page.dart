import 'package:flutter/material.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/profile/achievements_section.dart';
import 'package:phynd_app/presentation/widgets/profile/favorite_games.dart';
import 'package:phynd_app/presentation/widgets/profile/profile_header.dart';
import 'package:phynd_app/presentation/widgets/profile/quests_in_progress.dart';
import 'package:phynd_app/presentation/widgets/profile/recently_uploaded_clips.dart';

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
    _getUserDetails("deb49b9c-01de-4a72-9b88-987b9e5474df");
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
                    bannerImage: _userProfile?.user?.cover_image_url ??
                        'assets/images/profile_banner.png',
                    currentlyPlaying: 'Marvel Rivals'),

                // Stats Row
                Container(
                  color: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('0', 'Followers'),
                      _buildDivider(),
                      _buildStat('0', 'Following'),
                      _buildDivider(),
                      _buildStat('11', 'PHYND Coins'),
                      _buildDivider(),
                      _buildStat('0', 'Badges'),
                      _buildDivider(),
                      _buildStat('0', 'Clips'),
                    ],
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Favorite Games Section
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 300,
                            child: FavoriteGames(),
                          ),
                        ),

                        // Recently Uploaded Clips Section
                        const RecentlyUploadedClips(),
                        // Achievements Section
                        const AchievementsSection(),

                        // Quests in Progress Section
                        const QuestsInProgress(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.deepPurple,
    );
  }
}
