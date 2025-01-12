import 'package:firebase_database/firebase_database.dart';
import 'storage_service.dart';

class FCloudStorage implements StorageService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Future<void> clear(String table) async {
    // Löscht alle Daten in der angegebenen Tabelle
    await _database.ref(table).remove();
  }

  @override
  Future<void> delete(String table, String key) async {
    // Löscht einen spezifischen Datensatz basierend auf dem Schlüssel
    await _database.ref("$table/$key").remove();
  }

  @override
  Future<Map<String, dynamic>?> read(String table, String key) async {
    // Liest einen spezifischen Datensatz aus der Tabelle
    final snapshot = await _database.ref("$table/$key").get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> readAll(String table) async {
    // Liest alle Datensätze aus der Tabelle
    final snapshot = await _database.ref(table).get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return data.values.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  @override
  Future<void> save(
      String table,
      Map<String, dynamic> data,
      String Function(Map<String, dynamic>) keySelector,
      ) async {
    // Speichert oder aktualisiert einen Datensatz
    final key = keySelector(data);
    await _database.ref("$table/$key").set(data);
  }
}
