import 'package:flutter/material.dart';
import 'package:phynd_app/presentation/widgets/heading/slider_heading.dart';

class GameClipSlider extends StatelessWidget {
  final List<Widget> cards;
  final String title;
  const GameClipSlider({
    super.key,
    required this.cards,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    int cardsToShow = 4;
    double cardAspectRatio = 16 / 9;
    double spacing = 8;
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the available width for cards after accounting for spacing
    double availableWidth = screenWidth - (spacing * (cardsToShow - 1));
    double cardWidth = availableWidth / cardsToShow;

    // Calculate card height based on the aspect ratio
    double cardHeight = cardWidth / cardAspectRatio;

    // Adjust number of cards to show based on screen width
    if (screenWidth < 600) {
      cardsToShow = 2;
      cardWidth = (screenWidth - spacing) / cardsToShow;
      cardHeight = cardWidth / cardAspectRatio;
    } else if (screenWidth < 1200) {
      cardsToShow = 3;
      cardWidth = (screenWidth - (spacing * (cardsToShow - 1))) / cardsToShow;
      cardHeight = cardWidth / cardAspectRatio;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SliderHeading(title),
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                cards.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0
                        ? 0
                        : spacing, // No left padding for first card
                    right: index == cards.length - 1 ? 16 : 0,
                  ),
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: cards[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
