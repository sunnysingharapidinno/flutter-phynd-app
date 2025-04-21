import 'package:flutter/services.dart';

class RainwayPlugin {
  static const MethodChannel _channel = MethodChannel('com.rainway.sdk');

  static Future<void> initialize(String apiKey) async {
    await _channel.invokeMethod('initialize', {'apiKey': apiKey});
  }

  static Future<void> connect(String serverUrl, String apiKey, String gameId,
      String externalId, String availabilityZone) async {
    await _channel.invokeMethod('connect', {
      'serverUrl': serverUrl,
      'apiKey': apiKey,
      'gameId': gameId,
      'externalId': externalId,
      'availabilityZone': availabilityZone,
    });
  }

  static Future<void> startStreaming(String gameId, String apiKey) async {
    await _channel.invokeMethod('startStreaming', {
      'gameId': gameId,
      'apiKey': apiKey,
    });
  }

  static Future<void> stopStreaming(String apiKey) async {
    await _channel.invokeMethod('stopStreaming', {'apiKey': apiKey});
  }

  static Future<void> sendInput(
      Map<String, dynamic> input, String apiKey) async {
    await _channel.invokeMethod('sendInput', {
      'input': input,
      'apiKey': apiKey,
    });
  }

  static Future<bool> isStreaming(String apiKey) async {
    final bool result =
        await _channel.invokeMethod('isStreaming', {'apiKey': apiKey});
    return result;
  }
}
