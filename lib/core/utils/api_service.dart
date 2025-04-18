import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.get(url, headers: _defaultHeaders(headers));
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    final url = Uri.parse('$baseUrl$endpoint');

    return http.post(
      url,
      headers: _defaultHeaders(headers),
      body: jsonEncode(body ?? {}),
    );
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.put(
      url,
      headers: _defaultHeaders(headers),
      body: jsonEncode(body ?? {}),
    );
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) {
    final url = Uri.parse('$baseUrl$endpoint');
    return http.delete(url, headers: _defaultHeaders(headers));
  }

  Map<String, String> _defaultHeaders([Map<String, String>? customHeaders]) {
    return {'Content-Type': 'application/json', ...?customHeaders};
  }
}
