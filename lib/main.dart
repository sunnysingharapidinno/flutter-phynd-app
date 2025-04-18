import 'package:flutter/material.dart';
import 'package:phynd_app/config/env.dart';
import 'package:phynd_app/data/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

Future<void> main() async {
  try {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Load environment variables
    await Env.load();

    // Initialize SharedPreferences with error handling
    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('Warning: Failed to initialize SharedPreferences: $e');
    }

    final userService = UserService();
    runApp(MyApp(userService: userService));
  } catch (e) {
    print('Fatal error during initialization: $e');
    // You might want to show an error screen or handle this differently
    rethrow;
  }
}
