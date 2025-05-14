import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/cards/event_offer_card.dart';
import 'package:phynd_app/presentation/widgets/cards/genre_cards.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/profile/suggested_quest.dart';
import 'package:phynd_app/presentation/widgets/publisher/publisher_header.dart';
import 'package:phynd_app/presentation/widgets/publisher/latest_updates_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/trending_games_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/featured_games_section.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/section/home_section.dart';

class PublisherProfilePage extends StatelessWidget {
  const PublisherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final primaryColor = theme?.get('primary');
    final textColor = theme?.get('text');
    final textColor2 = theme?.get('subText2');
    final buttonBg = theme?.get('borderColors');
    final onlineColor = theme?.get('onlineIndicator');

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

    final games = [
      {
        'number': 1,
        'name': 'Grit',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/Grit.png',
      },
      {
        'number': 2,
        'name': 'Brawl Stars',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
      },
      {
        'number': 3,
        'name': 'Fortnite',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/fortniteHeros.jpeg',
      },
      {
        'number': 4,
        'name': 'Neon Racers',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
      },
      {
        'number': 5,
        'name': 'Mario Kart',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
      },
      {
        'number': 1,
        'name': 'Grit',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/Grit.png',
      },
      {
        'number': 2,
        'name': 'Brawl Stars',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
      },
      {
        'number': 3,
        'name': 'Fortnite',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/fortniteHeros.jpeg',
      },
      {
        'number': 4,
        'name': 'Neon Racers',
        'image':
            'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
      },
      {
        'number': 5,
        'name': 'Mario Kart',
        'image': 'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
      },
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
            backgroundImages: [
              'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
              'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
            ],
            followersCount: '1.4k',
            gamesCount: "16",
            publisherCircularLogoUrl:
                'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
            publisherNameArtUrl:
                'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png',
            upcomingEventsCount: '12',
            isVerified: true,
          ),

          // Follow section with button and followers
          SizedBox(height: SizeUtils.pxToDp(context, 48)),

          // Follow Section

          Padding(
            padding: EdgeInsets.fromLTRB(SizeUtils.pxToDp(context, 32), 0,
                SizeUtils.pxToDp(context, 120), 0),
            child: Column(
              children: [
                Row(
                  children: [
                    PrimaryButton(
                      text: "Follow",
                      onPressed: () {},
                      height: 92,
                      width: 400,
                      borderRadius: 12,
                      fontSize: 40,
                      backgroundColor: buttonBg,
                      borderColor: textColor,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 80)),
                    ImageThumbnail(
                      imageUrl: AppImages.peopleLogoGreyBg,
                      width: 90,
                      height: 90,
                      borderRadius: 200,
                      fit: BoxFit.contain,
                      isNetwork: false,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 19)),
                    Text(
                      "86 Friends Follow Studio 369",
                      style: TextStyle(
                        fontSize: FontUtils.pxToSp(context, 48),
                        color: textColor2,
                        fontFamily: 'Exo2',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 28)),
                    Container(
                      width: SizeUtils.pxToDp(context, 40),
                      height: SizeUtils.pxToDp(context, 40),
                      decoration: BoxDecoration(
                        color: onlineColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 19)),
                    Text(
                      "12 online",
                      style: TextStyle(
                        fontSize: FontUtils.pxToSp(context, 40),
                        color: textColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 48)),
                HomeSection(
                  cardSpacing: 20,
                  cardsPerView: 4,
                  heading: 'Featured Games',
                  sectionHeight: 300,
                  items: games,
                  cardBuilder: (context, game, width, index) {
                    return GameClipCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                      videoUrl:
                          'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                      gameName: 'Heroes of Mavia',
                      badge: const Ratings(rating: 1.0),
                      esrbImageUrl:
                          'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
                    );
                  },
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 48)),
                HomeSection(
                  cardSpacing: 20,
                  cardsPerView: 4,
                  heading: 'Latest Updates',
                  sectionHeight: SizeUtils.pxToDp(context, 520),
                  items: games,
                  cardBuilder: (context, game, width, index) {
                    return GameClipCard(
                      imageUrl:
                          'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                      videoUrl:
                          'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                      gameName: 'Heroes of Mavia',
                      badge: const Ratings(rating: 1.0),
                      esrbImageUrl:
                          'https://xstrela-uat.s3.us-east-1.amazonaws.com/ESRB/everyone.png',
                    );
                  },
                ),

                // Events and Offers Section
                SizedBox(height: SizeUtils.pxToDp(context, 48)),
                HomeSection(
                  cardSpacing: 20,
                  cardsPerView: 2,
                  heading: 'Events and Offers',
                  sectionHeight: 510,
                  items: games,
                  cardBuilder: (context, game, width, index) {
                    return EventOfferCard(
                      backgroundImageUrl:
                          'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',

                      publisherLogoUrl:
                          "https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca",
                      gameTitle: "Valorant",
                      isVerified: true,
                      friendsSavedCount: 86,
                      height: 327,
                      width: double.infinity,
                      // onSavePressed: eventsOffers[0]['onSavePressed'],
                    );
                  },
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 48)),
                HomeSection(
                  cardSpacing: 20,
                  cardsPerView: 5,
                  heading: 'Genres',
                  sectionHeight: 200,
                  items: games,
                  cardBuilder: (context, game, width, index) {
                    return GenreCard(
                      imageUrl:
                          'https://xstrela-alpha.s3.us-east-1.amazonaws.com/gdb-phynd/publisher-page-tv-screen/game-genre-action/metal-slug-awakening/metal-slug-awakening.jpg',
                      title: "Action",
                      width: double.infinity,
                    );
                  },
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 48)),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: EventsOffersSection(
          //     eventsOffers: eventsOffers,
          //     primaryColor: primaryColor!,
          //     textColor: textColor!,
          //   ),
          // ),

          // Latest Updates Section
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: LatestUpdatesSection(
          //     latestUpdates: latestUpdates,
          //     primaryColor: primaryColor,
          //     textColor: textColor,
          //   ),
          // ),

          // Trending Games Section
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: TrendingGamesSection(
          //     trendingGames: trendingGames,
          //     primaryColor: primaryColor,
          //     textColor: textColor,
          //   ),
          // ),

          // // Featured Games Section
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: FeaturedGamesSection(
          //     featuredGames: featuredGames,
          //     primaryColor: primaryColor,
          //     textColor: textColor,
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: const SuggestedQuest(),
          // ),
        ],
      ),
    );
  }
}
