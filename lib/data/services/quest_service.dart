import 'dart:convert';

import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';

class QuestService {
  final String baseURL = ApiBaseUrl.flutterAppQuestBaseUrl.url;
  late final ApiService api;

  QuestService() {
    api = ApiService(baseUrl: baseURL);
  }

  Future<List<QuestModel>> getUserQuests({
    List<String>? questStatus,
    int? page,
    int? limit,
    // ignore: non_constant_identifier_names
    String? sort_by,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'quest_status': questStatus,
        'page': page,
        'limit': limit,
        'sort_by': sort_by,
      };
      final response = await api.post(ServerAPIEndpoints.getUserQuests,
          body: requestBody, auth: true);
      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = jsonDecode(response.body);
        List<QuestModel> quests = [];
        if (data['data'] != null && data['data'] is List) {
          quests = (data['data'] as List)
              .map((questJson) => QuestModel.fromJson(questJson))
              .toList();
        }

        return quests;
      } else {
        throw Exception('Failed to fetch quests: ');
      }
    } catch (e) {
      print('Error fetching quests: $e');
      return [];
    }
  }

  Future<List<QuestModel>> getQuests({
    List<String>? questStatus,
    int? page,
    int? limit,
    // ignore: non_constant_identifier_names
    String? sort_by,
    // ignore: non_constant_identifier_names
    bool? is_featured,
    // ignore: non_constant_identifier_names
    bool? is_trending,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'quest_status': questStatus,
        'page': page,
        'limit': limit,
        'sort_by': sort_by,
        'is_featured': is_featured,
        'is_trending': is_trending,
      };
      final response = await api.post(ServerAPIEndpoints.getQuests,
          body: requestBody, auth: true);

      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = jsonDecode(response.body);
        List<QuestModel> quests = [];
        if (data['data'] != null && data['data'] is List) {
          quests = (data['data'] as List)
              .map((questJson) => QuestModel.fromJson(questJson))
              .toList();
        }

        return quests;
      } else {
        throw Exception('Failed to fetch quests: ');
      }
    } catch (e) {
      print('Error fetching quests: $e');
      return [];
    }
  }

  Future<QuestModel> getQuestDetails({
    String? questId,
  }) async {
    try {
      final url = '${ServerAPIEndpoints.getQuestDetails}?quest_id=$questId';
      final response = await api.get(url, auth: true);
      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          return QuestModel.fromJson(data);
        } else {
          throw Exception('Invalid quest data format');
        }
      } else {
        throw Exception(
            'Failed to fetch quest details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching quest details: $e');
      throw Exception('Failed to get quest details: $e');
    }
  }

  Future<List<QuestMissionModel>> getQuestMissions({
    String? questId,
  }) async {
    try {
      final url = '${ServerAPIEndpoints.getQuestMissions}?quest_id=$questId';
      final response = await api.get(url, auth: true);

      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data == null) {
          throw Exception('Invalid response format: null data');
        }

        List<dynamic> missionsList;
        if (data is List) {
          missionsList = data;
        } else if (data is Map<String, dynamic>) {
          if (data['data'] is List) {
            missionsList = data['data'];
          } else {
            throw Exception(
                'Invalid response format: data field is not a List');
          }
        } else {
          throw Exception(
              'Invalid response format: expected List or Map with data field');
        }

        return missionsList
            .map((json) => QuestMissionModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to fetch quest missions: ${response.statusCode}');
      }
    } catch (e) {
      if (e is TypeError) {
        print('TypeError details: ${e.toString()}');
      }
      throw Exception('Failed to get quest missions: $e');
    }
  }
}
