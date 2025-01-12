import 'dart:collection';

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
    // Normalisiere den Schlüssel
    final key = normalizeKey(keySelector(data));
    final DatabaseReference ref = _database.ref('$table/$key');

    // Überprüfe und normalisiere die Daten
    final normalizedData = normalizeDataKeys(data);

    // Check if data already exists
    final snapshot = await ref.get();
    if (snapshot.exists) {
      // Update existing data
      await ref.update(normalizedData);
    } else {
      // Add new data
      await ref.set(normalizedData);
    }
  }

  @override
  Future<Map<String, dynamic>?> read(String table, String key) async {
    final normalizedKey = normalizeKey(key);
    final DatabaseReference ref = _database.ref('$table/$normalizedKey');
    final snapshot = await ref.get();

    if (snapshot.exists && snapshot.value is Map) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String table) async {
    final DatabaseReference ref = _database.ref(table);
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final rawData = snapshot.value;
      print("Raw Firebase Data: $rawData"); // Debug-Ausgabe

      if (rawData is List) {
        // Normalisiere List-Daten
        return rawData
            .where((element) => element != null) // Entferne null-Werte
            .map((element) {
          if (element is Map) {
            return Map<String, dynamic>.from(element);
          } else {
            return {"value": element};
          }
        })
            .toList();
      } else if (rawData is Map) {
        // Normalisiere Map-Daten
        final data = Map<String, dynamic>.from(rawData);
        return data.entries.map((entry) {
          final key = entry.key.toString();
          final value = entry.value;
          if (value is Map) {
            return {"id": key, ...Map<String, dynamic>.from(value)};
          } else {
            return {"id": key, "value": value};
          }
        }).toList();
      }
    }
    return [];
  }

  @override
  Future<void> delete(String table, String key) async {
    final normalizedKey = normalizeKey(key);
    final DatabaseReference ref = _database.ref('$table/$normalizedKey');
    await ref.remove();
  }

  @override
  Future<void> clear(String table) async {
    final DatabaseReference ref = _database.ref(table);
    await ref.remove();
  }

  // Hilfsfunktion zur Schlüssel-Normalisierung
  String normalizeKey(String key) {
    return key.replaceAll(RegExp(r'[.#$/\[\]]'), '_');
  }

  // Rekursive Funktion zur Normalisierung von verschachtelten Schlüsseln
  Map<String, dynamic> normalizeDataKeys(Map<String, dynamic> data) {
    final Map<String, dynamic> normalizedData = {};
    data.forEach((key, value) {
      final normalizedKey = normalizeKey(key);
      if (value is Map) {
        normalizedData[normalizedKey] = normalizeDataKeys(Map<String, dynamic>.from(value));
      } else if (value is LinkedHashMap) {
        normalizedData[normalizedKey] = normalizeDataKeys(Map<String, dynamic>.from(value));
      } else {
        normalizedData[normalizedKey] = value;
      }
    });
    return normalizedData;
  }
}
