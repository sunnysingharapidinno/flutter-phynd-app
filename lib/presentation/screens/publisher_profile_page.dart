import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/profile/suggested_quest.dart';
import 'package:phynd_app/presentation/widgets/publisher/publisher_header.dart';
import 'package:phynd_app/presentation/widgets/publisher/follow_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/latest_updates_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/trending_games_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/featured_games_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/events_offers_section.dart';

class PublisherProfilePage extends StatelessWidget {
  const PublisherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary') ?? Colors.blue;
    final textColor = theme?.get('text') ?? Colors.black;

    // Sample stats for the publisher header
    final Map<String, int> publisherStats = {
      'followers': 7,
      'games': 1672,
      'clans': 3,
      'trials': 40,
      'drops': 13,
      'upcomingEvents': 14,
      'quests': 28,
    };

    // Sample follower avatars
    final List<String> followerAvatars = [
      'https://img.icons8.com/3d-fluency/94/person-male--v2.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v3.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v4.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v5.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v6.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v7.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v8.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v9.png',
      'https://img.icons8.com/3d-fluency/94/person-male--v10.png',
    ];

    // Sample data for events and offers
    final List<Map<String, dynamic>> eventsOffers = [
      {
        'imageUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',
        'title': 'SNK World Championship',
        'timeRemaining': '4 Days 11 Hours 37 Min',
        'friendsCount': 34,
        'friendAvatars': followerAvatars,
        'actionText': 'Register Now',
        'type': 'event',
      },
      {
        'imageUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',
        'title': 'The King of Fighters',
        'friendsCount': 34,
        'friendAvatars': followerAvatars,
        'actionText': 'Buy Now',
        'type': 'offer',
      },
    ];

    // Sample data for latest updates
    final List<Map<String, dynamic>> latestUpdates = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '2 Hrs Ago',
        'duration': '8:14',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'KOF XV Season 2 Balancing Update',
        'friendsWatched': 35,
        'friendAvatarUrls': followerAvatars.sublist(0, 5),
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '1 Day Ago',
        'duration': '5:22',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Metal Slug Tactics - Release Date Trailer',
        'friendsWatched': 18,
        'friendAvatarUrls': followerAvatars.sublist(2, 5),
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '3 Days Ago',
        'duration': '10:45',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Fatal Fury: City of the Wolves - Gameplay Preview',
        'friendsWatched': 42,
        'friendAvatarUrls': followerAvatars.sublist(1, 5),
      },
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.amazonaws.com/images/Fortnite.jpeg',
        'timeAgo': '1 Week Ago',
        'duration': '3:17',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Samurai Shodown - New DLC Character Announcement',
        'friendsWatched': 27,
        'friendAvatarUrls': followerAvatars.sublist(3, 6),
      },
    ];

    // Sample data for trending games
    final List<Map<String, dynamic>> trendingGames = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',
        'timeAgo': 'New',
        'duration': '60hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'The King of Fighters XV',
        'friendsWatched': 12468,
        'friendAvatarUrls': followerAvatars.sublist(0, 6),
      },
      {
        'thumbnailUrl':
            "https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg",
        'timeAgo': 'Coming Soon',
        'duration': '40hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Metal Slug Tactics',
        'friendsWatched': 8745,
        'friendAvatarUrls': followerAvatars.sublist(2, 5),
      },
      {
        'thumbnailUrl':
            "https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg",
        'timeAgo': 'Popular',
        'duration': '30hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Samurai Shodown',
        'friendsWatched': 6529,
        'friendAvatarUrls': followerAvatars.sublist(1, 4),
      },
      {
        'thumbnailUrl':
            "https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg",
        'timeAgo': 'Coming Soon',
        'duration': '50hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Fatal Fury: City of the Wolves',
        'friendsWatched': 9321,
        'friendAvatarUrls': followerAvatars.sublist(3, 7),
      },
    ];

    // Sample data for featured games
    final List<Map<String, dynamic>> featuredGames = [
      {
        'thumbnailUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',
        'timeAgo': 'Featured',
        'duration': '60hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Metal Slug Awakening',
        'friendsWatched': 15872,
        'friendAvatarUrls': followerAvatars.sublist(0, 6),
      },
      {
        'thumbnailUrl':
            "https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg",
        'timeAgo': 'Featured',
        'duration': '45hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'King of Fighters All Star',
        'friendsWatched': 9876,
        'friendAvatarUrls': followerAvatars.sublist(2, 5),
      },
      {
        'thumbnailUrl':
            "https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg",
        'timeAgo': 'Featured',
        'duration': '35hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'Metal Slug: Defense',
        'friendsWatched': 7532,
        'friendAvatarUrls': followerAvatars.sublist(1, 4),
      },
      {
        'thumbnailUrl':
            "https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg",
        'timeAgo': 'Featured',
        'duration': '55hrs+',
        'username': 'SNK_CORP',
        'userAvatarUrl':
            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
        'isVerified': true,
        'clipTitle': 'SNK vs. Capcom: Match of the Millennium',
        'friendsWatched': 10254,
        'friendAvatarUrls': followerAvatars.sublist(3, 7),
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(
          0), // Remove padding to allow header to extend full width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with banner, profile, title, and stats
          PublisherHeader(
            name: 'SNK_CORP',
            profileImageUrl:
                'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
            bannerImageUrl:
                'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/hero-section/hero2/hero2.png',
            stats: publisherStats,
          ),

          // Follow section with button and followers
          const SizedBox(height: 8),

          // Follow Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FollowSection(
              publisherName: 'SNK_CORP',
              followersCount: 86,
              followerAvatars: followerAvatars,
              onFollowPressed: () {
                // Handle follow action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Follow action triggered')),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Events and Offers Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: EventsOffersSection(
              eventsOffers: eventsOffers,
              primaryColor: primaryColor,
              textColor: textColor,
            ),
          ),

          // Latest Updates Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LatestUpdatesSection(
              latestUpdates: latestUpdates,
              primaryColor: primaryColor,
              textColor: textColor,
            ),
          ),

          // Trending Games Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TrendingGamesSection(
              trendingGames: trendingGames,
              primaryColor: primaryColor,
              textColor: textColor,
            ),
          ),

          // Featured Games Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FeaturedGamesSection(
              featuredGames: featuredGames,
              primaryColor: primaryColor,
              textColor: textColor,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const SuggestedQuest(),
          ),
        ],
      ),
    );
  }
}
