import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/cards/game_activity_card.dart';
import 'package:phynd_app/presentation/widgets/cards/game_trials_card.dart';
import 'package:phynd_app/presentation/widgets/cards/publisher_card.dart';
import 'package:phynd_app/presentation/widgets/cards/user_card.dart';
import 'package:phynd_app/presentation/widgets/section/section.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return BaseLayout(
      title: 'Search',
      child: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search games, friends, clips...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.get('textSecondary'),
                  ),
                  filled: true,
                  fillColor: theme.get('cardBg'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.get('borderColor')),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.get('borderColor')),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.get('primary')),
                  ),
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Games section
                    Section(
                      title: 'Games',
                      showViewAll: true,
                      child: SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) => GameTrialsCard(
                            imageUrl: 'https://picsum.photos/200/300',
                            title: 'Game ${index + 1}',
                            rating: 4.5,
                            trialDuration: '2 hours',
                            price: '\$59.99',
                            coinPrice: '5000',
                          ),
                        ),
                      ),
                    ),

                    // Game Publishers section
                    Section(
                      title: 'Game Publishers',
                      showViewAll: true,
                      child: SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) => PublisherCard(
                            logoUrl: 'https://picsum.photos/200/200',
                            name: 'Publisher ${index + 1}',
                          ),
                        ),
                      ),
                    ),

                    // Friends Activity section
                    Section(
                      title: "Friends' Activity",
                      showViewAll: true,
                      child: SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) => GameActivityCard(
                            imageUrl: 'https://picsum.photos/200/300',
                            title: 'Amazing Gameplay Moment',
                            username: 'Player${index + 1}',
                            timestamp: '${index + 1}h ago',
                          ),
                        ),
                      ),
                    ),

                    // Users section
                    Section(
                      title: 'Users',
                      showViewAll: true,
                      child: SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) => UserCard(
                            avatarUrl: 'https://picsum.photos/200/200',
                            username: 'User${index + 1}',
                            isOnline: index % 2 == 0,
                          ),
                        ),
                      ),
                    ),

                    // Free Trials section
                    Section(
                      title: 'Free Trials',
                      showViewAll: true,
                      child: SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: 5,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) => GameTrialsCard(
                            imageUrl: 'https://picsum.photos/200/300',
                            title: 'Trial Game ${index + 1}',
                            rating: 4.0 + (index * 0.2),
                            trialDuration: '${index + 1} hours',
                            price: 'Free',
                            coinPrice: '${(index + 1) * 1000}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
