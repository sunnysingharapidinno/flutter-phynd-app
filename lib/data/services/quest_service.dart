import 'dart:convert';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/core/utils/storage_service.dart';
import 'package:phynd_app/data/models/response/quest_model.dart';

class QuestService {
  final String baseURL = ApiBaseUrl.flutterAppQuestBaseUrl.url;
  late final ApiService api;
  static const String _tokenKey = 'auth_token';
  final StorageService _storage = StorageService();

  QuestService() {
    api = ApiService(baseUrl: baseURL);
  }

  Future<List<QuestModel>> getUserQuests({
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
}
