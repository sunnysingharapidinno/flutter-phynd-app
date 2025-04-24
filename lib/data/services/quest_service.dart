import 'dart:convert';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/core/utils/storage_service.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestService {
  final String baseURL = ApiBaseUrl.flutterAppQuestBaseUrl.url;
  late final ApiService api;
  static const String _tokenKey = 'auth_token';
  final StorageService _storage = StorageService();

  QuestService() {
    api = ApiService(baseUrl: baseURL);
  }

  Future<Map<String, dynamic>> getUserQuests({
    List<String>? questStatus,
    int? page,
    int? limit,
  }) async {
    final token = await _storage.get(_tokenKey);

    try {
      final Map<String, dynamic> requestBody = {
        'quest_status': questStatus,
        'page': page,
        'limit': limit,
      };

      // Add query parameters to the URL for better debugging
      final response = await api.post(
        ServerAPIEndpoints.getUserQuests,
        body: requestBody,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.body.isEmpty) {
        throw Exception('Empty response from server');
      }

      final statusCode = response.statusCode;
      Map<String, dynamic> data;

      try {
        data = jsonDecode(response.body);
      } catch (e) {
        throw Exception('Invalid response format: ${response.body}');
      }

      if (statusCode == 200) {
        print('data: $data');
        return data;
      } else {
        throw Exception(data['message'] ??
            'Quest fetch failed with status code: $statusCode');
      }
    } catch (e) {
      print('Error fetching quests: $e');
      rethrow;
    }
  }

  Future<List<QuestModel>> getUserQuestsModel({
    List<String>? questStatus,
    int? page,
    int? limit,
  }) async {
    final response = await getUserQuests(
      questStatus: questStatus,
      page: page,
      limit: limit,
    );

    try {
      if (response.containsKey('data') && response['data'] is List) {
        final List<dynamic> questsList = response['data'] as List<dynamic>;
        return questsList
            .map((questJson) =>
                QuestModel.fromJson(questJson as Map<String, dynamic>))
            .toList();
      } else if (response is List) {
        final List<dynamic> questsList = response as List<dynamic>;
        return questsList
            .map((questJson) =>
                QuestModel.fromJson(questJson as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      print('Error converting quests to model: $e');
      return [];
    }
  }
}
