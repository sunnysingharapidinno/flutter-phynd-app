import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phynd_app/core/enums/storage.dart';
import 'package:phynd_app/core/utils/storage_service.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);
    return http.get(url, headers: finalHeaders);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);

    return http.post(
      url,
      headers: finalHeaders,
      body: jsonEncode(body ?? {}),
    );
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);

    return http.put(
      url,
      headers: finalHeaders,
      body: jsonEncode(body ?? {}),
    );
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);
    return http.delete(url, headers: finalHeaders);
  }

  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? customHeaders,
    bool auth,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      ...?customHeaders,
    };

    if (auth) {
      final token = await _getAuthToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<String?> _getAuthToken() async {
    // Implement your token retrieval logic here
    // For example, using your StorageService
    final storage = StorageService();
    return await storage.get(StorageType.authToken.value);
  }
}
