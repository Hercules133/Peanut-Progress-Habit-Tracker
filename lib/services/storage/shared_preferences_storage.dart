import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPreferencesStorage implements StorageService {
  SharedPreferences? _prefs;

  SharedPreferencesStorage() {
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> save(String table, Map<String, dynamic> data) async {
    final prefs = await _getPrefs();
    final List<String> items = prefs.getStringList(table) ?? [];
    final existingIndex = items.indexWhere((item) {
      final decoded = jsonDecode(item);
      return decoded['id'] == data['id'];
    });

    if (existingIndex != -1) {
      items[existingIndex] = jsonEncode(data);
    } else {
      items.add(jsonEncode(data));
    }

    await prefs.setStringList(table, items);
  }

  @override
  Future<Map<String, dynamic>?> read(String table, String key) async {
    final prefs = await _getPrefs();
    final List<String> items = prefs.getStringList(table) ?? [];
    final item = items.firstWhere(
      (item) => jsonDecode(item)['id'] == key,
      orElse: () => '',
    );

    return item.isNotEmpty ? jsonDecode(item) : null;
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String table) async {
    final prefs = await _getPrefs();
    final List<String> items = prefs.getStringList(table) ?? [];
    return items
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<void> delete(String table, String key) async {
    final prefs = await _getPrefs();
    final List<String> items = prefs.getStringList(table) ?? [];
    items.removeWhere((item) => jsonDecode(item)['id'].toString() == key);
    await prefs.setStringList(table, items);
  }

  @override
  Future<void> clear(String table) async {
    final prefs = await _getPrefs();
    await prefs.remove(table);
  }
}
