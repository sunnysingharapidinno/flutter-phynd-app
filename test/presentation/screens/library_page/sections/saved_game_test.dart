import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_game.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';

@GenerateMocks([GameService])
import 'saved_game_test.mocks.dart';

void main() {
  late MockGameService mockGameService;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    mockGameService = MockGameService();
    // Default stub to avoid null return
    when(mockGameService.getSavedGames(
      page: 1,
      limit: 10,
    )).thenAnswer((_) async => (
          data: <FavoriteGame>[],
          currentPage: 1,
          totalPage: 1,
          total: 0,
          remainingPages: 0
        ));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: SavedGameSection(gameService: mockGameService),
      ),
    );
  }

  group('SavedGameSection Widget Tests', () {
    // testWidgets('shows no data widget when content is empty',
    //     (WidgetTester tester) async {
    //   when(mockGameService.getSavedGames(
    //     page: 1,
    //     limit: 10,
    //   )).thenAnswer((_) async => (
    //         data: <FavoriteGame>[],
    //         currentPage: 1,
    //         totalPage: 1,
    //         total: 0,
    //         remainingPages: 0
    //       ));

    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();

    //   expect(find.text('No Saved Games'), findsOneWidget);
    //   expect(find.text("You haven't saved any games yet"), findsOneWidget);
    // });

    testWidgets('displays saved games when content is available',
        (WidgetTester tester) async {
      final mockGames = [
        FavoriteGame(
          gameSlug: 'game-1',
          title: 'Game 1',
          imageUrl: 'https://example.com/game1.jpg',
          trailerUrl: 'https://example.com/game1.mp4',
          rating: 4.5,
          esrbRatingUrl: 'https://example.com/esrb1.png',
          createdAt: DateTime.now(),
        ),
        FavoriteGame(
          gameSlug: 'game-2',
          title: 'Game 2',
          imageUrl: 'https://example.com/game2.jpg',
          trailerUrl: 'https://example.com/game2.mp4',
          rating: 4.0,
          esrbRatingUrl: 'https://example.com/esrb2.png',
          createdAt: DateTime.now(),
        ),
      ];

      when(mockGameService.getSavedGames(
        page: 1,
        limit: 10,
      )).thenAnswer((_) async => (
            data: mockGames,
            currentPage: 1,
            totalPage: 1,
            total: 2,
            remainingPages: 0
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Saved Games'), findsOneWidget);
      expect(find.byType(GameClipCard), findsNWidgets(2));
    });

    testWidgets('handles error state gracefully', (WidgetTester tester) async {
      when(mockGameService.getSavedGames(
        page: 1,
        limit: 10,
      )).thenThrow(Exception('Network error'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // The widget only prints the error, so we check that loading is gone and no data widget is shown
      expect(find.text('No Saved Games'), findsOneWidget);
    });
  });
}
