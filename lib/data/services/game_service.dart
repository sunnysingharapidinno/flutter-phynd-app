import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phynd_app/config/app_config.dart';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/enums/player_profile_section_type.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/data/models/payload/game_payload_model.dart';
import 'package:phynd_app/data/models/response/favorite_content_model.dart';
import 'package:phynd_app/data/models/response/game_list_model.dart';
import 'package:phynd_app/data/models/response/game_model.dart';
import 'package:phynd_app/data/models/response/like_follow_model.dart';
import 'package:phynd_app/data/models/response/player_profile_game.dart';
import 'package:phynd_app/data/models/response/video_model.dart';
import 'package:phynd_app/data/models/response/recent_history_model.dart';

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
      debugPrint("data: ${data}");
      return LikeFollowStatus.fromJson(data);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<
      ({
        List<FavoriteGame> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getFavoriteGames({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getFavoriteGames}?page=$page&limit=$limit');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<FavoriteGame> games = (responseData['data'] as List)
            .map((gameJson) => FavoriteGame.fromJson(gameJson))
            .toList();
        return (
          data: games,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception(
            'Failed to fetch favorite games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching favorite games: $e');
    }
  }

  Future<
      ({
        List<FavoriteGame> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getSavedGames({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getSavedGames}?page=$page&limit=$limit');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<FavoriteGame> games = (responseData['data'] as List)
            .map((gameJson) => FavoriteGame.fromJson(gameJson))
            .toList();
        return (
          data: games,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception(
            'Failed to fetch favorite games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching favorite games: $e');
    }
  }

  Future<
      ({
        List<FavoriteContent> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getSavedContent({
    int page = 1,
    int limit = 10,
    required String contentType,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getSavedContent}?page=$page&limit=$limit&content_type=$contentType');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<FavoriteContent> content = (responseData['data'] as List)
            .map((contentJson) => FavoriteContent.fromJson(contentJson))
            .toList();
        return (
          data: content,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception(
            'Failed to fetch saved content: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching saved content: $e');
    }
  }

  Future<
      ({
        List<FavoriteContent> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getFavoriteContent({
    int page = 1,
    int limit = 10,
    required String contentType,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getFavoriteContent}?page=$page&limit=$limit&content_type=$contentType');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<FavoriteContent> content = (responseData['data'] as List)
            .map((contentJson) => FavoriteContent.fromJson(contentJson))
            .toList();
        return (
          data: content,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception(
            'Failed to fetch favorite content: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching favorite content: $e');
    }
  }

  Future<
      ({
        List<FavoriteVideo> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getFavoriteVideos({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getFavoriteContent}?page=$page&limit=$limit');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<FavoriteVideo> videos = (responseData['data'] as List)
            .map((videoJson) => FavoriteVideo.fromJson(videoJson))
            .toList();
        return (
          data: videos,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception(
            'Failed to fetch favorite videos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching favorite videos: $e');
    }
  }

  Future<
      ({
        List<FavoriteVideo> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getSavedVideos({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getSavedContent}?page=$page&limit=$limit&content_type=VIDEO');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<FavoriteVideo> videos = (responseData['data'] as List)
            .map((videoJson) => FavoriteVideo.fromJson(videoJson))
            .toList();
        return (
          data: videos,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception('Failed to fetch saved videos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching saved videos: $e');
    }
  }

  Future<({int count, List<PlayerProfileGame> data})>
      getPlayerProfileSectionGames({
    int page = 1,
    int limit = AppConfig.pageLimit,
    required PlayerProfileSectionType sectionType,
    required String userId,
    String? search,
  }) async {
    try {
      final response = await api.get(
          ServerAPIEndpoints.getPlayerProfileSectionGames,
          auth: true,
          queryParams: {
            'page': page.toString(),
            'limit': limit.toString(),
            'section': sectionType.value,
            'user_id': userId,
            "search": search,
          });

      final data = jsonDecode(response.body);

      final List<PlayerProfileGame> gameList = (data['data'] as List)
          .map((gameJson) => PlayerProfileGame.fromJson(gameJson))
          .toList();
      debugPrint("data: ${data}");
      return (count: data['total'] as int, data: gameList);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<
      ({
        List<RecentHistory> data,
        int total,
        int totalPage,
        int currentPage,
        int remainingPages
      })> getRecentHistory({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final url = Uri.parse(
          '${ServerAPIEndpoints.getRecentHistory}?page=$page&limit=$limit');
      final response = await api.get(
        url.toString(),
        auth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<RecentHistory> games = (responseData['data'] as List)
            .map((gameJson) => RecentHistory.fromJson(gameJson))
            .toList();
        return (
          data: games,
          total: responseData['total'] as int,
          totalPage: responseData['total_page'] as int,
          currentPage: responseData['current_page'] as int,
          remainingPages: responseData['remaining_pages'] as int
        );
      } else {
        throw Exception(
            'Failed to fetch recent history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recent history: $e');
    }
  }
}
