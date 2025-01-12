import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'storage_service.dart';

class FCloudStorage implements StorageService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Future<void> save(
      String table,
      Map<String, dynamic> data,
      String Function(Map<String, dynamic>) keySelector,
      ) async {
    final key = keySelector(data);
    final DatabaseReference ref = _database.ref('$table/$key');

    // Check if data already exists
    final snapshot = await ref.get();
    if (snapshot.exists) {
      // Update existing data
      await ref.update(data);
    } else {
      // Add new data
      await ref.set(data);
    }
  }

  @override
  Future<Map<String, dynamic>?> read(String table, String key) async {
    final DatabaseReference ref = _database.ref('$table/$key');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String table) async {
    final DatabaseReference ref = _database.ref(table);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return data.values.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  @override
  Future<void> delete(String table, String key) async {
    final DatabaseReference ref = _database.ref('$table/$key');
    await ref.remove();
  }

  @override
  Future<void> clear(String table) async {
    final DatabaseReference ref = _database.ref(table);
    await ref.remove();
  }
}
