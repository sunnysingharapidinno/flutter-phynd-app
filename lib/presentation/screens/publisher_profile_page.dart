import 'package:flutter/material.dart';
import 'package:phynd_app/core/constants/app_images.dart';
import 'package:phynd_app/core/constants/ui_constants.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/core/utils/font_utils.dart';
import 'package:phynd_app/core/utils/size_utils.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/data/models/response/pub_hero_model.dart';
import 'package:phynd_app/data/models/response/pub_stats_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:phynd_app/presentation/widgets/buttons/primary_button.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';
import 'package:phynd_app/presentation/widgets/cards/event_offer_card.dart';
import 'package:phynd_app/presentation/widgets/cards/genre_cards.dart';
import 'package:phynd_app/presentation/widgets/cards/video_cards.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';
import 'package:phynd_app/presentation/widgets/loader/circular_load.dart';
import 'package:phynd_app/presentation/widgets/notifier.dart';
import 'package:phynd_app/presentation/widgets/profile/suggested_quest.dart';
import 'package:phynd_app/presentation/widgets/publisher/publisher_header.dart';
import 'package:phynd_app/presentation/widgets/publisher/latest_updates_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/trending_games_section.dart';
import 'package:phynd_app/presentation/widgets/publisher/featured_games_section.dart';
import 'package:phynd_app/presentation/widgets/ratings/ratings.dart';
import 'package:phynd_app/presentation/widgets/carousel/carousel_row.dart';
import 'package:timeago/timeago.dart' as timeago;

class PublisherProfilePage extends StatefulWidget {
  final String userId;

  const PublisherProfilePage({super.key, required this.userId});

  @override
  State<PublisherProfilePage> createState() => _PublisherProfilePageState();
}

class _PublisherProfilePageState extends State<PublisherProfilePage> {
  final UserService _userService = UserService();
  final GameService _gameService = GameService();
  bool _isLoading = false;
  Profile? _userProfile;
  bool _checkingFollow = false;
  bool _isFollowed = false;
  PubStatsModel? _pubStats;
  List<PubHero>? _pubHero;

  @override
  void initState() {
    super.initState();

    _fetchUserProfileById(widget.userId);

    _checkPubFollowed();

    _getPubStats();

    _getPubHero();
  }

  Future<void> _getPubHero() async {
    try {
      final pubHero = await _gameService.getPubHero(pubId: widget.userId);
      setState(
        () => _pubHero = pubHero.data,
      );
    } catch (e) {
      debugPrint("Error getting pub stats: $e");
    }
  }

  Future<void> _getPubStats() async {
    try {
      final pubStats =
          await _gameService.getPublisherStats(userId: widget.userId);
      setState(
        () => _pubStats = pubStats,
      );
    } catch (e) {
      debugPrint("Error getting pub stats: $e");
    }
  }

  Future<void> _checkPubFollowed() async {
    try {
      final status =
          await _userService.checkIsPubFollowed(userId: widget.userId);
      setState(
        () => _isFollowed = status.isFollowing ?? false,
      );
    } catch (e) {
      debugPrint("Error checking follow status: $e");
    }
  }

  Future<void> _fetchUserProfileById(String userId) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final profile = await _userService.getUserById(userId: userId);
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      debugPrint('Error fetching profile by ID: $e');
    }
  }

  Future<void> _handleFollowBtn() async {
    try {
      setState(() => _checkingFollow = true);
      if (_isFollowed) {
        await _userService.unFollowPub(userId: widget.userId);
      } else {
        await _userService.followPub(userId: widget.userId);
      }

      Notifier.show(context,
          '${_userProfile?.user.display_name ?? "Publisher"} ${_isFollowed ? 'unfollowed' : 'followed'} successfully');

      await _checkPubFollowed();
    } catch (e) {
      Notifier.show(context,
          'Error ${_isFollowed ? 'unfollow' : 'following'} ${_userProfile?.user.display_name ?? "Publisher"}');
    } finally {
      setState(() => _checkingFollow = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();

    final textColor = theme?.get('text');
    final textColor2 = theme?.get('subText2');
    final buttonBg = theme?.get('borderColors');
    final onlineColor = theme?.get('onlineIndicator');

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

    if (_isLoading) {
      return const Center(child: CircularLoad());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublisherHeader(
            backgroundImages: _pubHero
                    ?.map((hero) => hero.heroImageUrl)
                    .whereType<String>()
                    .toList() ??
                [],

            // backgroundImages: const [
            //   'https://picsum.photos/id/237/536/354',
            //   'https://picsum.photos/seed/picsum/536/354',
            //   'https://picsum.photos/id/1084/536/354?grayscale',
            //   'https://picsum.photos/id/1060/536/354?blur=2',
            //   'https://picsum.photos/id/870/536/354?grayscale&blur=2',
            // ],
            followersCount: '1.4k',
            gamesCount: _pubStats?.gamesCount.toString() ?? '0',
            publisherCircularLogoUrl: _userProfile?.user.dp_url,
            publisherNameArtUrl: _userProfile?.user.cover_image_url,
            upcomingEventsCount: _pubStats?.upcomingEvents.toString() ?? '0',
            isVerified: _userProfile?.user.is_verified,
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
                      text: _isFollowed ? 'Following' : 'Follow',
                      onPressed: () {
                        _handleFollowBtn();
                      },
                      height: 92,
                      width: 400,
                      borderRadius: 12,
                      fontSize: 40,
                      backgroundColor: buttonBg,
                      borderColor: textColor,
                      isLoading: _checkingFollow,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 80)),
                    const ImageThumbnail(
                      imageUrl: AppImages.peopleLogoGreyBg,
                      width: 90,
                      height: 90,
                      borderRadius: 200,
                      fit: BoxFit.contain,
                      isNetwork: false,
                    ),
                    SizedBox(width: SizeUtils.pxToDp(context, 19)),
                    Text(
                      "86 Friends Follow Studio ${_userProfile?.user.display_name}",
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
                CarouselRow(
                  cardSpacing: UIConstants.cardSpacing,
                  cardsPerView: UIConstants.defaultCardsPerView,
                  heading: 'Featured Games',
                  sectionHeight: 350,
                  handleApiCall: (page) async {
                    return _gameService.getPubFeaturedGame(
                        pubId: widget.userId, page: page);
                  },
                  cardBuilder: (context, game, width, index) {
                    return GameClipCard(
                      height: 207,
                      thumbnailUrl: game.coverUrl,
                      videoUrl:
                          'https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4',
                      title: game.name,
                      rating: game.starRatings ?? 0,
                      esrbRatingImageUrl: game.esrbImgUrl,
                    );
                  },
                ),

                SizedBox(height: SizeUtils.pxToDp(context, 48)),
                CarouselRow(
                  cardSpacing: UIConstants.cardSpacing,
                  cardsPerView: UIConstants.defaultCardsPerView,
                  heading: 'Latest Updates',
                  sectionHeight: 420,
                  handleApiCall: (page) async {
                    return _gameService.getPubLatestUpdates(
                        pubId: widget.userId, page: page);
                  },
                  cardBuilder: (context, update, width, index) {
                    return VideoCard(
                        thumbnailUrl: update.imageUrl,
                        videoUrl: update.videoUrl,
                        height: 227,
                        timeAgo:
                            timeago.format(DateTime.parse(update.updatedAt!)),
                        duration: '12:00',
                        title: update.title,
                        publisherAvatarUrl:
                            'https://xstrela-alpha.s3.us-east-1.amazonaws.com/images/temp/DP_IMAGE_URL/PNG/8005f2f1-6d23-4521-84d4-91f16ac200ca',
                        isVerified: true,
                        publisherName: 'NetEase Studios',
                        friendsWatchedCount: 10);
                  },
                ),

                // Events and Offers Section
                SizedBox(height: SizeUtils.pxToDp(context, 48)),
                CarouselRow(
                  cardSpacing: UIConstants.cardSpacing,
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
                CarouselRow(
                  cardSpacing: UIConstants.cardSpacing,
                  cardsPerView: 5,
                  heading: 'Genres',
                  sectionHeight: 200,
                  handleApiCall: (page) async {
                    return _gameService.getPubGameGenre(
                        pubId: widget.userId, page: page);
                  },
                  cardBuilder: (context, genre, width, index) {
                    return GenreCard(
                      imageUrl: genre.imageUrl,
                      title: genre.name,
                      width: double.infinity,
                    );
                  },
                ),
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
