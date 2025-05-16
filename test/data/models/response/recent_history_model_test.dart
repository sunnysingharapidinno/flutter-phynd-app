import 'package:flutter_test/flutter_test.dart';
import 'package:phynd_app/data/models/response/recent_history_model.dart';

void main() {
  group('RecentHistory Model Tests', () {
    test('should create RecentHistory from JSON', () {
      final json = {
        'game_slug': 'test-game-123',
        'last_played': '2025-05-16T07:30:51.518977',
        'title': 'Test Game',
        'description': 'Test Description',
        'company_name': 'Test Company',
        'company_image': 'https://example.com/image.jpg',
        'organization_id': 'org-123',
        'image_url': 'https://example.com/game.jpg',
        'esrb': 'https://example.com/esrb.png',
        'rating_count': 100,
        'rating': 4.5,
      };

      final recentHistory = RecentHistory.fromJson(json);

      expect(recentHistory.gameSlug, equals('test-game-123'));
      expect(recentHistory.lastPlayed,
          equals(DateTime.parse('2025-05-16T07:30:51.518977')));
      expect(recentHistory.title, equals('Test Game'));
      expect(recentHistory.description, equals('Test Description'));
      expect(recentHistory.companyName, equals('Test Company'));
      expect(
          recentHistory.companyImage, equals('https://example.com/image.jpg'));
      expect(recentHistory.organizationId, equals('org-123'));
      expect(recentHistory.imageUrl, equals('https://example.com/game.jpg'));
      expect(recentHistory.esrb, equals('https://example.com/esrb.png'));
      expect(recentHistory.ratingCount, equals(100));
      expect(recentHistory.rating, equals(4.5));
    });

    test('should create RecentHistory with null optional fields', () {
      final json = {
        'game_slug': 'test-game-123',
        'last_played': '2025-05-16T07:30:51.518977',
        'title': 'Test Game',
        'image_url': 'https://example.com/game.jpg',
        'esrb': 'https://example.com/esrb.png',
      };

      final recentHistory = RecentHistory.fromJson(json);

      expect(recentHistory.gameSlug, equals('test-game-123'));
      expect(recentHistory.lastPlayed,
          equals(DateTime.parse('2025-05-16T07:30:51.518977')));
      expect(recentHistory.title, equals('Test Game'));
      expect(recentHistory.description, isNull);
      expect(recentHistory.companyName, isNull);
      expect(recentHistory.companyImage, isNull);
      expect(recentHistory.organizationId, isNull);
      expect(recentHistory.imageUrl, equals('https://example.com/game.jpg'));
      expect(recentHistory.esrb, equals('https://example.com/esrb.png'));
      expect(recentHistory.ratingCount, isNull);
      expect(recentHistory.rating, isNull);
    });

    test('should convert RecentHistory to JSON', () {
      final recentHistory = RecentHistory(
        gameSlug: 'test-game-123',
        lastPlayed: DateTime.parse('2025-05-16T07:30:51.518977'),
        title: 'Test Game',
        description: 'Test Description',
        companyName: 'Test Company',
        companyImage: 'https://example.com/image.jpg',
        organizationId: 'org-123',
        imageUrl: 'https://example.com/game.jpg',
        esrb: 'https://example.com/esrb.png',
        ratingCount: 100,
        rating: 4.5,
      );

      final json = recentHistory.toJson();

      expect(json['game_slug'], equals('test-game-123'));
      expect(json['last_played'], equals('2025-05-16T07:30:51.518977'));
      expect(json['title'], equals('Test Game'));
      expect(json['description'], equals('Test Description'));
      expect(json['company_name'], equals('Test Company'));
      expect(json['company_image'], equals('https://example.com/image.jpg'));
      expect(json['organization_id'], equals('org-123'));
      expect(json['image_url'], equals('https://example.com/game.jpg'));
      expect(json['esrb'], equals('https://example.com/esrb.png'));
      expect(json['rating_count'], equals(100));
      expect(json['rating'], equals(4.5));
    });
  });
}
