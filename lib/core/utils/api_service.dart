import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:phynd_app/core/enums/storage.dart';
import 'package:phynd_app/core/utils/storage_service.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String?>? queryParams,
    bool auth = false,
  }) async {
    Map<String, String?>? filteredQueryParams;
    if (queryParams != null) {
      filteredQueryParams = Map.from(queryParams)
        ..removeWhere((key, value) => value == null);
    }

    final uri = Uri.parse('$baseUrl$endpoint')
        .replace(queryParameters: filteredQueryParams);
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);

    try {
      final response = await http.get(uri, headers: finalHeaders);
      _handleResponse(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);

    Map<String, dynamic>? filteredBody;
    if (body != null) {
      filteredBody =
          Map.fromEntries(body.entries.where((entry) => entry.value != null));
    }

    try {
      final response = await http.post(
        url,
        headers: finalHeaders,
        body: jsonEncode(filteredBody ?? {}),
      );
      _handleResponse(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);

    Map<String, dynamic>? filteredBody;
    if (body != null) {
      filteredBody =
          Map.fromEntries(body.entries.where((entry) => entry.value != null));
    }

    try {
      final response = await http.put(
        url,
        headers: finalHeaders,
        body: jsonEncode(filteredBody ?? {}),
      );
      _handleResponse(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool auth = false,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final Map<String, String> finalHeaders = await _buildHeaders(headers, auth);

    Map<String, dynamic>? filteredBody;
    if (body != null) {
      filteredBody =
          Map.fromEntries(body.entries.where((entry) => entry.value != null));
    }

    try {
      final response = await http.delete(
        url,
        headers: finalHeaders,
        body: jsonEncode(filteredBody ?? {}),
      );
      _handleResponse(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  void _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300) {
      String message = 'Request failed with status: $statusCode';

      try {
        final body = jsonDecode(response.body);
        if (body is Map && body['message'] != null) {
          message = body['message'];
        }
      } catch (_) {
        // ignore JSON parsing errors
      }

      throw HttpException(message, uri: response.request?.url);
    }
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
    final storage = StorageService();
    return await storage.get(StorageType.authToken.value);
  }
}
