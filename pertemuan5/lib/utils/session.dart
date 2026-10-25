import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan sesi login (user id) di local storage.
class Session {
  static const _key = 'logged_user_id';

  static Future<void> save(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
