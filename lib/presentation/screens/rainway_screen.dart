import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/rainway_service.dart';

class RainwayPage extends StatefulWidget {
  const RainwayPage({Key? key}) : super(key: key);

  @override
  _RainwayPageState createState() => _RainwayPageState();
}

class _RainwayPageState extends State<RainwayPage> {
  final RainwayService _rainwayService = RainwayService();
  static const String _apiKey = 'pk_live_rKsImIZXqkFfMRS2dd3ROlsZ';
  static const String _serverUrl = 'https://gdc-api.phynd.games/play';
  static const String _gameId = '388c1c22-cd10-4ea2-be02-9f5c84876726';
  static const String _externalId = 'f9abac96-02a5-46b7-9270-553ffffbba1a';
  static const String _availabilityZone = 'us-west-1';
  bool _isInitialized = false;
  bool _isConnected = false;
  bool _isStreaming = false;

  @override
  void initState() {
    super.initState();
    _initializeRainway();
  }

  Future<void> _initializeRainway() async {
    try {
      await _rainwayService.initialize(_apiKey);
      setState(() {
        _isInitialized = true;
      });
      _showMessage('Rainway initialized successfully');
    } catch (e) {
      _showMessage('Failed to initialize Rainway: $e');
    }
  }

  Future<void> _connectToServer() async {
    try {
      await _rainwayService.connect(
          _serverUrl, _apiKey, _gameId, _externalId, _availabilityZone);
      setState(() {
        _isConnected = true;
      });
      _showMessage('Connected to server successfully');
    } catch (e) {
      _showMessage('Failed to connect to server: $e');
    }
  }

  Future<void> _startStreaming() async {
    try {
      await _rainwayService.startStreaming(_gameId, _apiKey);
      setState(() {
        _isStreaming = true;
      });
      _showMessage('Streaming started successfully');
    } catch (e) {
      _showMessage('Failed to start streaming: $e');
    }
  }

  Future<void> _stopStreaming() async {
    try {
      await _rainwayService.stopStreaming(_apiKey);
      setState(() {
        _isStreaming = false;
      });
      _showMessage('Streaming stopped successfully');
    } catch (e) {
      _showMessage('Failed to stop streaming: $e');
    }
  }

  Future<void> _sendInput() async {
    try {
      await _rainwayService.sendInput({
        'type': 'keyboard',
        'key': 'A',
        'pressed': true,
      }, _apiKey);
      _showMessage('Input sent successfully');
    } catch (e) {
      _showMessage('Failed to send input: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rainway Integration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isInitialized ? null : _initializeRainway,
              child: const Text('Initialize Rainway'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed:
                  !_isInitialized || _isConnected ? null : _connectToServer,
              child: const Text('Connect to Server'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: !_isConnected || _isStreaming ? null : _startStreaming,
              child: const Text('Start Streaming'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: !_isStreaming ? null : _stopStreaming,
              child: const Text('Stop Streaming'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: !_isStreaming ? null : _sendInput,
              child: const Text('Send Input'),
            ),
            const SizedBox(height: 16),
            Text(
              'Status:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Initialized: $_isInitialized'),
            Text('Connected: $_isConnected'),
            Text('Streaming: $_isStreaming'),
          ],
        ),
      ),
    );
  }
}
