import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:phynd_app/data/models/response/recent_history_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/recent_history.dart';
import 'package:phynd_app/presentation/widgets/cards/clip_card/game_clip_card.dart';

@GenerateMocks([GameService])
import 'recent_history_section_test.mocks.dart';

void main() {
  late MockGameService mockGameService;

  setUp(() {
    mockGameService = MockGameService();
  });

  testWidgets('RecentHistorySection displays loading state initially',
      (WidgetTester tester) async {
    when(mockGameService.getRecentHistory(
      page: anyNamed('page'),
      limit: anyNamed('limit'),
    )).thenAnswer((_) async => (
          data: <RecentHistory>[],
          total: 0,
          totalPage: 0,
          currentPage: 1,
          remainingPages: 0
        ));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecentHistorySection(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('RecentHistorySection displays games when data is loaded',
      (WidgetTester tester) async {
    final mockGames = [
      RecentHistory(
        gameSlug: 'test-game-1',
        lastPlayed: DateTime.now(),
        title: 'Test Game 1',
        imageUrl: 'https://example.com/game1.jpg',
        esrb: 'https://example.com/esrb1.png',
      ),
      RecentHistory(
        gameSlug: 'test-game-2',
        lastPlayed: DateTime.now(),
        title: 'Test Game 2',
        imageUrl: 'https://example.com/game2.jpg',
        esrb: 'https://example.com/esrb2.png',
      ),
    ];

    when(mockGameService.getRecentHistory(
      page: anyNamed('page'),
      limit: anyNamed('limit'),
    )).thenAnswer((_) async => (
          data: mockGames,
          total: 2,
          totalPage: 1,
          currentPage: 1,
          remainingPages: 0
        ));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecentHistorySection(),
        ),
      ),
    );

    // Wait for the loading to complete
    await tester.pumpAndSettle();

    // Verify that the games are displayed
    expect(find.text('Test Game 1'), findsOneWidget);
    expect(find.text('Test Game 2'), findsOneWidget);
  });

  testWidgets('RecentHistorySection handles empty data',
      (WidgetTester tester) async {
    when(mockGameService.getRecentHistory(
      page: anyNamed('page'),
      limit: anyNamed('limit'),
    )).thenAnswer((_) async => (
          data: <RecentHistory>[],
          total: 0,
          totalPage: 0,
          currentPage: 1,
          remainingPages: 0
        ));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecentHistorySection(),
        ),
      ),
    );

    // Wait for the loading to complete
    await tester.pumpAndSettle();

    // Verify that no games are displayed
    expect(find.byType(GameClipCard), findsNothing);
  });

  testWidgets('RecentHistorySection handles error state',
      (WidgetTester tester) async {
    when(mockGameService.getRecentHistory(
      page: anyNamed('page'),
      limit: anyNamed('limit'),
    )).thenThrow(Exception('Failed to fetch games'));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RecentHistorySection(),
        ),
      ),
    );

    // Wait for the loading to complete
    await tester.pumpAndSettle();

    // Verify that no games are displayed
    expect(find.byType(GameClipCard), findsNothing);
  });
}
