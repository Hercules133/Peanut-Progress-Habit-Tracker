abstract class StorageService {
  Future<void> save(String table, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> read(String table, String key);
  Future<List<Map<String, dynamic>>> readAll(String table);
  Future<void> delete(String table, String key);
  Future<void> clear(String table);
}
