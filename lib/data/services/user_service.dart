import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phynd_app/config/app_config.dart';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/enums/storage.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/core/utils/storage_service.dart';
import 'package:phynd_app/data/models/response/friend_item.dart';
import 'package:phynd_app/data/models/response/player_profile_stats.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';
import 'package:phynd_app/data/models/response/terms_and_conditions_model.dart';

class UserService {
  final String baseURL = ApiBaseUrl.flutterAppUserBaseUrl.url;
  late final ApiService api;
  final StorageService _storage = StorageService();

  UserService() {
    api = ApiService(baseUrl: baseURL);
  }

  Future<String?> _getAuthToken() async {
    return await _storage.get(StorageType.authToken.value);
  }

  Future<void> _clearAuthToken() async {
    await _storage.remove(StorageType.authToken.value);
  }

  Future<Map<String, dynamic>> loginUser({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await api.post(
        ServerAPIEndpoints.logInUrl,
        body: {'email': userId, 'password': password},
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
        // Save the token if login is successful
        if (data['jwt_token'] != null) {
          final storage = StorageService();
          await storage.set(StorageType.authToken.value, data['jwt_token']);
        }

        return {
          'jwt_token': data['jwt_token'],
          'is_publisher': data['is_publisher'] ?? false,
          'is_publisher_blocked': data['is_publisher_blocked'] ?? false,
          'is_user_baned': data['is_user_baned'] ?? false,
          'is_user_blocked': data['is_user_blocked'] ?? false,
          'publisher_blocked_reason': data['publisher_blocked_reason'],
          'user_ban_reason': data['user_ban_reason'],
          'user_blocked_reason': data['user_blocked_reason'],
        };
      } else if (statusCode == 307) {
        return {
          'jwt_token': null,
          'is_publisher': false,
          'is_publisher_blocked': false,
          'is_user_baned': false,
          'is_user_blocked': false,
          'publisher_blocked_reason': null,
          'user_ban_reason': null,
          'user_blocked_reason': null,
        };
      } else {
        throw Exception(
            data['message'] ?? 'Login failed with status code: $statusCode');
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      rethrow;
    }
  }

  Future<Profile> getUserMyDetails() async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await api.get(
        ServerAPIEndpoints.getUserMyDetails,
        auth: true,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Profile.fromJson(data);
      } else if (response.statusCode == 401) {
        // Clear the token if unauthorized
        await _clearAuthToken();
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      rethrow;
    }
  }

  Future<Profile> getUserById({required String userId}) async {
    try {
      final response =
          await api.get(ServerAPIEndpoints.getUserDetails + userId);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Data: $data');
        var profile = Profile.fromJson(data);
        return profile;
      } else {
        throw Exception('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      rethrow;
    }
  }

  Future<TermsAndConditions> getTermsAndConditions(
      {String? contentType}) async {
    try {
      String url = ServerAPIEndpoints.getTAndC;

      // Attach content_type to URL if provided
      if (contentType != null && contentType.isNotEmpty) {
        url += '?content_type=$contentType';
      }

      final response = await api.get(url, auth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TermsAndConditions.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch terms and conditions: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching terms and conditions: $e');
      rethrow;
    }
  }

  Future<({int count, List<FriendItem> data})> getFriendsList({
    int page = 1,
    int limit = AppConfig.pageLimit,
    String? search,
  }) async {
    try {
      final response = await api
          .get(ServerAPIEndpoints.getMyFriends, auth: true, queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'search': search ?? '',
      });

      final data = jsonDecode(response.body);

      final List<FriendItem> friendList = (data['data'] as List)
          .map((gameJson) => FriendItem.fromJson(gameJson))
          .toList();

      return (count: data['total'] as int, data: friendList);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<({int count, List<FriendItem> data})> getFriendRequestList({
    int page = 1,
    int limit = AppConfig.pageLimit,
    String? search,
  }) async {
    try {
      final response = await api.get(ServerAPIEndpoints.getFriendRequestList,
          auth: true,
          queryParams: {
            'page': page.toString(),
            'limit': limit.toString(),
            'search': search ?? '',
          });

      final data = jsonDecode(response.body);

      final List<FriendItem> friendList = (data['data'] as List)
          .map((gameJson) => FriendItem.fromJson(gameJson))
          .toList();

      return (count: data['total'] as int, data: friendList);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<void> acceptFriendRequest({required String requestId}) async {
    try {
      await api.post(
        ServerAPIEndpoints.acceptFriendRequest
            .replaceAll('{request_id}', requestId),
        auth: true,
      );
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<void> rejectFriendRequest({required String requestId}) async {
    try {
      await api.post(
        ServerAPIEndpoints.rejectFriendRequest
            .replaceAll('{request_id}', requestId),
        auth: true,
      );
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }

  Future<PlayerProfileStats> getPlayerProfileStats({
    required String userId,
  }) async {
    try {
      final response = await api.get(
        ServerAPIEndpoints.getPlayerProfileStats.replaceAll('{userid}', userId),
        auth: true,
      );

      final data = jsonDecode(response.body);

      return PlayerProfileStats.fromJson(data);
    } catch (e) {
      throw Exception('Invalid response format: $e');
    }
  }
}
