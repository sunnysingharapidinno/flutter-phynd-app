import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/widgets/profile/game_card.dart';
import 'package:phynd_app/presentation/widgets/common/section_heading.dart';

class FavoriteGames extends StatelessWidget {
  const FavoriteGames({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>();
    final textColor = theme?.get('text') ?? Colors.white;
    final primaryColor = theme?.get('primary') ?? Colors.deepPurple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Favorite Games',
          textColor: textColor,
          accentColor: primaryColor,
          showSeeAll: false,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  GameCard(
                    number: 1,
                    name: 'Grit',
                    image:
                        'https://xstrela-alpha.s3.amazonaws.com/images/Grit.png',
                  ),
                  GameCard(
                    number: 2,
                    name: 'Brawl Stars',
                    image:
                        'https://xstrela-alpha.s3.amazonaws.com/images/BrawlStars.jpeg',
                  ),
                  GameCard(
                    number: 3,
                    name: 'Fortnite',
                    image:
                        'https://xstrela-alpha.s3.amazonaws.com/images/fortniteHeros.jpeg',
                  ),
                  GameCard(
                    number: 4,
                    name: 'Neon Racers',
                    image:
                        'https://xstrela-alpha.s3.amazonaws.com/images/NeonCarsPoster.jpeg',
                  ),
                  GameCard(
                      number: 5,
                      name: 'Mario Kart',
                      image:
                          'https://xstrela-alpha.s3.amazonaws.com/images/MarioKarts.png'),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
