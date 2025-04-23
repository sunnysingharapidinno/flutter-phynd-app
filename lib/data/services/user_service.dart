import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/data/models/response/profile_model.dart';

class UserService {
  final String baseURL = ApiBaseUrl.flutterAppUserBaseUrl.url;
  late final ApiService api;
  static const String _tokenKey = 'auth_token';
  SharedPreferences? _prefs;

  UserService() {
    api = ApiService(baseUrl: baseURL);
    _initPrefs();
  }

  // Constructor for quest service
  UserService.forQuest() {
    api = ApiService(baseUrl: ApiBaseUrl.flutterAppQuestBaseUrl.url);
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('Warning: Failed to initialize SharedPreferences: $e');
    }
  }

  Future<String?> _getAuthToken() async {
    if (_prefs == null) {
      await _initPrefs();
    }
    return _prefs?.getString(_tokenKey);
  }

  Future<void> setAuthToken(String token) async {
    if (_prefs == null) {
      await _initPrefs();
    }
    await _prefs?.setString(_tokenKey, token);
  }

  Future<void> clearAuthToken() async {
    if (_prefs == null) {
      await _initPrefs();
    }
    await _prefs?.remove(_tokenKey);
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

      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');

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
        print(data['jwt_token']);
        if (data['jwt_token'] != null) {
          await setAuthToken(data['jwt_token']);
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
      print('Error during login: $e');
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
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Profile.fromJson(data);
      } else if (response.statusCode == 401) {
        // Clear the token if unauthorized
        await clearAuthToken();
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      rethrow;
    }
  }

  Future<Profile> getUserById({required String userId}) async {
    try {
      final response =
          await api.get(ServerAPIEndpoints.getUserDetails + userId);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data: $data');
        var profile = Profile.fromJson(data);
        return profile;
      } else if (response.statusCode == 401) {
        // Clear the token if unauthorized
        await clearAuthToken();
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserQuests({
    List<String>? questStatus,
    int? page,
    int? limit,
  }) async {
    const String tokenKey =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJ3ZWIzYXV0aCIsInN1YiI6ImRlYjQ5YjljLTAxZGUtNGE3Mi05Yjg4LTk4N2I5ZTU0NzRkZiIsImlhdCI6MTc0NTQwOTUxMCwiZXhwIjoxNzQ1NDk1OTEwLCJuYmYiOjE3NDU0MDk1MTAsInJvbGVzIjpbIlBMQVlFUiJdLCJ3YWxsZXRzIjpbXSwic2lkIjoiZTMwYjZjYzQtOTA3OS00Njg4LTg1NTMtYzU4YjUxMGM4MzcwIn0.YZGgloXKvasE5IUrC3Z1SRKeo_B_wsZukPseQiF0obaet_L2AK2znLRaXFkJaoIk0r3iEEq8BKQlZm2ftQC7QSdHU6B0_twyu0xb2t9z4gsI9GL0IfLj3H6SmNwBg-AeoU24r1fusAJGhU2inG9CHY-c1UGo2kzAZE4eIYB0JZwt8JBobapgK0-NgMXuCsADQSNM0_0_CYCCa9jm4_zTPgVuEbe1bWOfjvv4auZKSkH0kTYvlgKFfW-0uoHOfdVQKkwwlYa6WnDJNBzK4N4pGwf6CrryqIQ5MzIpjpq8mWRcOal_MRDoDFAU5cdguwXQq8lsXWvWS7Bcbo4JqJeVgg';

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
          'Authorization': 'Bearer $tokenKey',
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
      } else if (statusCode == 401) {
        // Clear the token if unauthorized
        await clearAuthToken();
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception(data['message'] ??
            'Quest fetch failed with status code: $statusCode');
      }
    } catch (e) {
      print('Error fetching quests: $e');
      rethrow;
    }
  }
}
