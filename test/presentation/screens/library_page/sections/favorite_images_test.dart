import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:phynd_app/core/enums/media_type.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/services/game_service.dart';
import 'package:phynd_app/presentation/screens/library_page/sections/favorite_images.dart';
import 'package:phynd_app/presentation/widgets/image/image_thumbnail.dart';

@GenerateMocks([GameService])
import 'favorite_images_test.mocks.dart';

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
        body: FavoriteImagesSection(gameService: mockGameService),
      ),
    );
  }

  group('FavoriteImagesSection Widget Tests', () {
    testWidgets('shows no data widget when content is empty',
        (WidgetTester tester) async {
      when(mockGameService.getFavoriteContent(
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

      expect(find.text('No Favorited Images'), findsOneWidget);
      expect(
          find.text('You haven\'t favorited any images yet'), findsOneWidget);
    });

    testWidgets('displays favorited images when content is available',
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

      when(mockGameService.getFavoriteContent(
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

      expect(find.text('Favorited Images'), findsOneWidget);
      expect(find.byType(ImageThumbnail), findsNWidgets(2));
    });

    testWidgets('handles error state gracefully', (WidgetTester tester) async {
      when(mockGameService.getFavoriteContent(
        page: 1,
        limit: 10,
        contentType: 'IMAGE',
      )).thenThrow(Exception('Network error'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No Favorited Images'), findsOneWidget);
    });
  });
}
