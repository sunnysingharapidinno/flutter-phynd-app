import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_video.dart';

@GenerateMocks([GameService])
import 'favorite_video_test.mocks.dart';

void main() {
  late MockGameService mockGameService;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    mockGameService = MockGameService();
    // Default stub to avoid null return
    when(mockGameService.getFavoriteContent(
      page: 1,
      limit: 10,
      contentType: MediaType.video.value,
    )).thenAnswer((_) async => (
          data: <FavoriteContent>[],
          currentPage: 1,
          totalPage: 1,
          total: 0,
          remainingPages: 0
        ));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: FavoriteVideoSection(),
      ),
    );
  }

  group('FavoriteVideoSection Widget Tests', () {
    testWidgets('displays no data widget when content is empty',
        (WidgetTester tester) async {
      when(mockGameService.getFavoriteContent(
        page: 1,
        limit: 10,
        contentType: MediaType.video.value,
      )).thenAnswer((_) async => (
            data: <FavoriteContent>[],
            currentPage: 1,
            totalPage: 1,
            total: 0,
            remainingPages: 0
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No Favorited Videos'), findsOneWidget);
      expect(
          find.text('You haven\'t favorited any videos yet'), findsOneWidget);
    });

    // testWidgets('displays favorited videos when content is available',
    //     (WidgetTester tester) async {
    //   final mockContent = [
    //     FavoriteContent(
    //       gameSlug: 'game1',
    //       url: 'https://example.com/video1.mp4',
    //       createdAt: DateTime.now(),
    //       description: 'Test video 1',
    //       mediaType: MediaType.video,
    //       title: 'Test Video 1',
    //     ),
    //     FavoriteContent(
    //       gameSlug: 'game2',
    //       url: 'https://example.com/video2.mp4',
    //       createdAt: DateTime.now(),
    //       description: 'Test video 2',
    //       mediaType: MediaType.video,
    //       title: 'Test Video 2',
    //     ),
    //   ];

    //   when(mockGameService.getFavoriteContent(
    //     page: 1,
    //     limit: 10,
    //     contentType: MediaType.video.value,
    //   )).thenAnswer((_) async => (
    //         data: mockContent,
    //         currentPage: 1,
    //         totalPage: 1,
    //         total: 2,
    //         remainingPages: 0
    //       ));

    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();

    //   expect(find.byType(VideoCard), findsNWidgets(2));
    //   expect(find.text('Test Video 1'), findsOneWidget);
    //   expect(find.text('Test Video 2'), findsOneWidget);
    // });

    testWidgets('handles error state gracefully', (WidgetTester tester) async {
      when(mockGameService.getFavoriteContent(
        page: 1,
        limit: 10,
        contentType: MediaType.video.value,
      )).thenThrow(Exception('Network error'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // The widget only prints the error, so we check that loading is gone and no data widget is shown
      expect(find.text('No Favorited Videos'), findsOneWidget);
    });
  });
}
