import 'dart:convert';

import 'package:phynd_app/core/constants/base_server_endpoints.dart';
import 'package:phynd_app/core/enums/api_env.dart';
import 'package:phynd_app/core/utils/api_service.dart';
import 'package:phynd_app/core/utils/storage_service.dart';
import 'package:phynd_app/domain/models/terms_and_conditions.dart';

abstract class TermsAndConditionsService {
  Future<TermsAndConditions> getTermsAndConditions({String? contentType});
}

class TermsAndConditionsServiceImpl implements TermsAndConditionsService {
  final StorageService _storage = StorageService();
  final String _tokenKey = 'auth_token';
  final String baseURL = ApiBaseUrl.flutterAppUserBaseUrl.url;
  late final ApiService api;

  TermsAndConditionsServiceImpl() {
    api = ApiService(baseUrl: baseURL);
  }

  Future<String?> _getAuthToken() async {
    return await _storage.get(_tokenKey);
  }

  @override
  Future<TermsAndConditions> getTermsAndConditions(
      {String? contentType}) async {
    try {
      final token = await _getAuthToken();
      String url = ServerAPIEndpoints.getTAndC;

      // Attach content_type to URL if provided
      if (contentType != null && contentType.isNotEmpty) {
        url += '?content_type=$contentType';
      }

      final response = await api.get(
        url,
        headers: token != null
            ? {'Authorization': 'Bearer $token'}
            : {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TermsAndConditions.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch terms and conditions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching terms and conditions: $e');
      rethrow;
    }
  }
}
