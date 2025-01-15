import 'dart:convert';
import 'package:peanutprogress/services/storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A concrete implementation of [StorageService] that uses [SharedPreferences]
/// to persist and retrieve data.
class SharedPreferencesStorage implements StorageService {
  SharedPreferences? _prefs;

  SharedPreferencesStorage() {
    _initialize();
  }

  /// Initializes the [SharedPreferences] instance.
  ///
  /// This function is idempotent and may be called multiple times.
  ///
  /// It is automatically called in the constructor, so you don't need to call
  /// it unless you want to reinitialize the instance.
  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Returns the initialized [SharedPreferences] instance.
  ///
  /// If the instance has not been initialized yet (i.e., [_prefs] is null), it
  /// will be initialized using [SharedPreferences.getInstance].
  ///
  /// This function is idempotent: calling it multiple times will return the
  /// same instance.
  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> save(
    String table,
    Map<String, dynamic> data,
    String Function(Map<String, dynamic>) keySelector,
  ) async {
    final prefs = await _getPrefs();
    final List<String> items = prefs.getStringList(table) ?? [];
    final key = keySelector(data);
    final existingIndex = items.indexWhere((item) {
      final decoded = jsonDecode(item);
      return keySelector(decoded) == key;
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

    for (var item in items) {
      final Map<String, dynamic> decodedItem = jsonDecode(item);

      if (decodedItem.containsKey(key)) {
        return decodedItem;
      }
    }

    return null;
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
