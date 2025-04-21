import 'package:rainway_plugin/rainway_plugin.dart';

class RainwayService {
  Future<void> initialize(String apiKey) async {
    try {
      await RainwayPlugin.initialize(apiKey);
    } catch (e) {
      throw Exception('Failed to initialize Rainway: $e');
    }
  }

  Future<void> connect(String serverUrl, String apiKey, String gameId,
      String externalId, String availabilityZone) async {
    try {
      await RainwayPlugin.connect(
          serverUrl, apiKey, gameId, externalId, availabilityZone);
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> startStreaming(String gameId, String apiKey) async {
    try {
      await RainwayPlugin.startStreaming(gameId, apiKey);
    } catch (e) {
      throw Exception('Failed to start streaming: $e');
    }
  }

  Future<void> stopStreaming(String apiKey) async {
    try {
      await RainwayPlugin.stopStreaming(apiKey);
    } catch (e) {
      throw Exception('Failed to stop streaming: $e');
    }
  }

  Future<void> sendInput(Map<String, dynamic> input, String apiKey) async {
    try {
      await RainwayPlugin.sendInput(input, apiKey);
    } catch (e) {
      throw Exception('Failed to send input: $e');
    }
  }

  Future<bool> isStreaming(String apiKey) async {
    try {
      return await RainwayPlugin.isStreaming(apiKey);
    } catch (e) {
      throw Exception('Failed to check streaming status: $e');
    }
  }
}
