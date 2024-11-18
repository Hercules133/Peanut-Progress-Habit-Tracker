import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPreferencesStorage implements StorageService {
  late SharedPreferences _prefs;

  SharedPreferencesStorage() {
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> save(String table, Map<String, dynamic> data) async {
    final key = data['id'] ?? DateTime.now().toString();
    final tableKey = '$table-$key';
    await _prefs.setString(tableKey, jsonEncode(data));
  }

  @override
  Future<Map<String, dynamic>?> read(String table, String key) async {
    final tableKey = '$table-$key';
    final jsonString = _prefs.getString(tableKey);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String table) async {
    final keys = _prefs.getKeys().where((k) => k.startsWith('$table-'));
    return keys.map((k) {
      final jsonString = _prefs.getString(k);
      Map<String, dynamic> data = jsonDecode(jsonString ?? '');
      return data;
    }).toList();
  }

  @override
  Future<void> delete(String table, String key) async {
    final tableKey = '$table-$key';
    await _prefs.remove(tableKey);
  }

  @override
  Future<void> clear(String table) async {
    final keysToRemove = _prefs.getKeys().where((k) => k.startsWith('$table-'));
    for (var key in keysToRemove) {
      await _prefs.remove(key);
    }
  }
}
