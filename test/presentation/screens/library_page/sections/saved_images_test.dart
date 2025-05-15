import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/saved_images.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

@GenerateMocks([GameService])
import 'saved_images_test.mocks.dart';

void main() {
  late MockGameService mockGameService;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    mockGameService = MockGameService();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: SavedImagesSection(gameService: mockGameService),
      ),
    );
  }

  group('SavedImagesSection Widget Tests', () {
    // testWidgets('shows loading indicator initially',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(createWidgetUnderTest());

    //   expect(find.text('Loading...'), findsOneWidget);
    // });

    testWidgets('shows no data widget when content is empty',
        (WidgetTester tester) async {
      when(mockGameService.getSavedContent(
        page: 1,
        limit: 10,
        contentType: 'IMAGE',
      )).thenAnswer((_) async => (
            data: <FavoriteContent>[],
            total: 0,
            totalPage: 0,
            currentPage: 1,
            remainingPages: 0
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No Saved Images'), findsOneWidget);
      expect(find.text('You haven\'t saved any images yet'), findsOneWidget);
    });

    testWidgets('displays saved images when content is available',
        (WidgetTester tester) async {
      final mockContent = [
        FavoriteContent(
          gameSlug: 'game1',
          url: 'https://example.com/image1.jpg',
          createdAt: DateTime.now(),
          description: 'Test image 1',
          mediaType: MediaType.image,
        ),
        FavoriteContent(
          gameSlug: 'game2',
          url: 'https://example.com/image2.jpg',
          createdAt: DateTime.now(),
          description: 'Test image 2',
          mediaType: MediaType.image,
        ),
      ];

      when(mockGameService.getSavedContent(
        page: 1,
        limit: 10,
        contentType: 'IMAGE',
      )).thenAnswer((_) async => (
            data: mockContent,
            total: 2,
            totalPage: 1,
            currentPage: 1,
            remainingPages: 0
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Saved Images'), findsOneWidget);
      expect(find.byType(ImageThumbnail), findsNWidgets(2));
    });

    // testWidgets('handles error state gracefully', (WidgetTester tester) async {
    //   when(mockGameService.getSavedContent(
    //     page: 1,
    //     limit: 10,
    //     contentType: 'IMAGE',
    //   )).thenThrow(Exception('Network error'));

    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();

    //   // Should show no data widget when error occurs
    //   expect(find.text('No Saved Images'), findsOneWidget);
    // });

    //   testWidgets('loads more content when scrolling to end',
    //       (WidgetTester tester) async {
    //     final firstPageContent = List.generate(
    //       10,
    //       (index) => FavoriteContent(
    //         gameSlug: 'game$index',
    //         url: 'https://example.com/image$index.jpg',
    //         createdAt: DateTime.now(),
    //         description: 'Test image $index',
    //         mediaType: MediaType.image,
    //       ),
    //     );

    //     final secondPageContent = List.generate(
    //       5,
    //       (index) => FavoriteContent(
    //         gameSlug: 'game${index + 10}',
    //         url: 'https://example.com/image${index + 10}.jpg',
    //         createdAt: DateTime.now(),
    //         description: 'Test image ${index + 10}',
    //         mediaType: MediaType.image,
    //       ),
    //     );

    //     when(mockGameService.getSavedContent(
    //       page: 1,
    //       limit: 10,
    //       contentType: 'IMAGE',
    //     )).thenAnswer((_) async => (
    //           data: firstPageContent,
    //           total: 15,
    //           totalPage: 2,
    //           currentPage: 1,
    //           remainingPages: 1
    //         ));

    //     when(mockGameService.getSavedContent(
    //       page: 2,
    //       limit: 10,
    //       contentType: 'IMAGE',
    //     )).thenAnswer((_) async => (
    //           data: secondPageContent,
    //           total: 15,
    //           totalPage: 2,
    //           currentPage: 2,
    //           remainingPages: 0
    //         ));

    //     await tester.pumpWidget(createWidgetUnderTest());
    //     await tester.pumpAndSettle();

    //     // Initial load should show 10 items
    //     expect(find.byType(ImageThumbnail), findsNWidgets(10));

    //     // Scroll to end
    //     await tester.drag(find.byType(HomeSection), const Offset(0, -500));
    //     await tester.pumpAndSettle();

    //     // Should now show 15 items (10 from first page + 5 from second page)
    //     expect(find.byType(ImageThumbnail), findsNWidgets(15));
    //   });
  });
}
