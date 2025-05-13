import 'dart:convert';
import 'package:phynd_app/config/app_config.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/models/response/game_list_model.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/data/models/response/like_follow_model.dart';

class GameService {
  final String baseURL = ApiBaseUrl.flutterAppGameBaseUrl.url;
  late final ApiService api;

  GameService() {
    api = ApiService(baseUrl: baseURL);
  }

  Future<GameDetails> getGameDetails({
    required String gameSlug,
  }) async {
    try {
      final url = Uri.parse('${ServerAPIEndpoints.gameOverView}/$gameSlug');
      final response = await api.get(url.toString());

      final data = jsonDecode(response.body);
      return GameDetails.fromJson(data);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<({int count, List<GameItem> data})> getMarketplaceGames({
    int page = 1,
    int limit = AppConfig.pageLimit,
    GamePayload? filters,
  }) async {
    try {
      final mergedStudioIds = [
        ...(filters?.studioId ?? []),
        ...(filters?.developerId ?? []),
        ...(filters?.publisherId ?? []),
      ];

      List<String>? featuredTypes =
          filters?.featuredType?.map((type) => type.value).toList();

      final body = {
        ...?filters?.toJson(),
        'page': page,
        'limit': limit,
        'publisher_id': mergedStudioIds.isNotEmpty ? mergedStudioIds : null,
        'featured_type': featuredTypes,
        'game_chain': [],
        'network': "WEB3",
        'external_category': "gaming"
        // 'network': filters?.network ?? 'web3',
      };

      final response = await api.post(
        ServerAPIEndpoints.getGameList,
        body: body,
      );

      final data = json.decode(response.body);
      final List<GameItem> games = (data['games'] as List)
          .map((gameJson) => GameItem.fromJson(gameJson))
          .toList();

      return (count: data['count'] as int, data: games);
    } catch (e) {
      throw Exception('Failed to fetch marketplace games: $e');
    }
  }

  Future<void> followGame({
    required String gameSlug,
  }) async {
    try {
      await api.post(ServerAPIEndpoints.followGame,
          body: {
            'game_slug': gameSlug,
          },
          auth: true);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<void> favoriteSaveGame({
    required String gameSlug,
    bool? favorite,
    bool? saved,
  }) async {
    try {
      final url = Uri.parse('${ServerAPIEndpoints.favoriteSavedGame}/');
      await api.post(url.toString(),
          body: {
            'game_slug': gameSlug,
            "favorite": favorite,
            "saved": saved,
          },
          auth: true);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<void> removeFavoriteSaveGame({
    required String gameSlug,
    bool? favorite,
    bool? saved,
  }) async {
    try {
      final url = Uri.parse('${ServerAPIEndpoints.favoriteSavedGame}/');

      await api.delete(url.toString(),
          body: {
            'game_slug': gameSlug,
            "favorite": favorite,
            "saved": saved,
          },
          auth: true);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<void> unFollowGame({
    required String gameSlug,
  }) async {
    try {
      await api.delete(ServerAPIEndpoints.followGame,
          body: {
            'game_slug': gameSlug,
          },
          auth: true);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<LikeFollowStatus> checkLikeFollowGameStatus({
    required String gameSlug,
  }) async {
    try {
      final url =
          Uri.parse('${ServerAPIEndpoints.checkLikeFollowGame}/$gameSlug');
      final response = await api.get(url.toString(), auth: true);

      final data = jsonDecode(response.body);
      return LikeFollowStatus.fromJson(data);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }
}
