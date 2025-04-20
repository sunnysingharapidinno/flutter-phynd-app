import 'dart:convert';
import 'package:phynd_app/config/app_config.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/models/response/game_list_model.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';

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

  Future<({int count, List<Game> data})> getMarketplaceGames({
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

      final body = {
        ...?filters?.toJson(),
        'page': page,
        'limit': limit,
        'publisher_id': mergedStudioIds.isNotEmpty ? mergedStudioIds : null,
        'network': filters?.network ?? 'web3',
      };

      final response = await api.post(
        ServerAPIEndpoints.getGameList,
        body: body,
      );

      final data = json.decode(response.body);
      final List<Game> games = (data['games'] as List)
          .map((gameJson) => Game.fromJson(gameJson))
          .toList();

      return (count: data['count'] as int, data: games);
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch marketplace games: $e');
    }
  }
}
