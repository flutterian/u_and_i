import 'package:shared_preferences/shared_preferences.dart';

class FirstDayStorage {
  static const _key = 'firstDayIso';

  static Future<void> save(DateTime day) async {
    final prefs = await SharedPreferences.getInstance();
    final local = DateTime(day.year, day.month, day.day);
    await prefs.setString(_key, local.toIso8601String());
  }

  static Future<DateTime?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null) return null;
    try {
      final dt = DateTime.parse(s);
      return DateTime(dt.year, dt.month, dt.day);
    } catch (e) {
      return null;
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
