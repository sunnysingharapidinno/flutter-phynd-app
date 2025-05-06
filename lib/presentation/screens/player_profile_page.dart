import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:phynd_app/presentation/widgets/profile/achievements_section.dart';
import 'package:phynd_app/presentation/widgets/profile/favorite_games.dart';
import 'package:phynd_app/presentation/widgets/profile/profile_header.dart';
import 'package:phynd_app/presentation/widgets/profile/quests_in_progress.dart';
import 'package:phynd_app/presentation/widgets/profile/recently_uploaded_clips.dart';

class PlayerProfilePage extends StatefulWidget {
  final String? userId;

  const PlayerProfilePage({
    super.key,
    required this.userId,
  });

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
    _getUserDetails(widget.userId);
  }

  Future<void> _getUserDetails(String? userId) async {
    try {
      if (userId != null) {
        final profile = await _userService.getUserById(userId: userId);
        setState(() {
          _userProfile = profile;
          _isLoading = false;
        });
      } else {
        // Get current user's profile from AuthBloc
        final authState = context.read<AuthBloc>().state;
        setState(() {
          _userProfile = authState.profile;
          _isLoading = false;
        });
      }
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

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(
                      username: displayName,
                      isOnline: true,
                      avatar: _userProfile?.user.dp_url ??
                          'https://xstrela-alpha.s3.amazonaws.com/images/GamerAvatar1.jpeg',
                      bannerImage: _userProfile?.user?.cover_image_url ??
                          'https://xstrela-alpha.s3.amazonaws.com/images/profileCover.png',
                      currentlyPlaying: 'Marvel Rivals'),

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
