import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late SharedPreferences _prefs;

  /// Initialize the storage service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get a value from local storage
  Future<String?> get(String key) async {
    try {
      return _prefs.getString(key);
    } catch (e) {
      print('Error getting item from storage: $e');
      return null;
    }
  }

  /// Set a value in local storage
  Future<bool> set(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      print('Error setting item in storage: $e');
      return false;
    }
  }

  /// Remove a value from local storage
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      print('Error removing item from storage: $e');
      return false;
    }
  }

  /// Clear all items from local storage
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      print('Error clearing storage: $e');
      return false;
    }
  }
}
