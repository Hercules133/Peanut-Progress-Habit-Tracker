/// An abstract class defining the contract for storage services.
///
/// This class provides methods for saving, reading, deleting, and clearing data
/// from storage. The actual storage implementation (e.g., [SharedPreferencesStorage])
/// should implement these methods to handle the specific storage mechanics.
abstract class StorageService {
  /// Saves an item to the storage.
  ///
  /// [table] - The name of the "table" to store the item in.
  /// [data] - The item to store, represented as a map.
  /// [keySelector] - A function that takes the item and returns a key.
  /// The key is used to identify the item in the table. If an item with the
  /// same key already exists, it will be overwritten.
  Future<void> save(String table, Map<String, dynamic> data,
      String Function(Map<String, dynamic>) keySelector);

  /// Retrieves an item from the storage based on the specified table and key.
  ///
  /// [table] - The name of the table to search in.
  /// [key] - The key used to identify the item in the table.
  ///
  /// Returns a [Map<String, dynamic>] representing the stored item, or null ifq
  /// the item is not found.
  Future<Map<String, dynamic>?> read(String table, String key);

  /// Retrieves all items from the specified table.
  ///
  /// [table] - The name of the table to retrieve all items from.
  ///
  /// Returns a list of [Map<String, dynamic>] representing all stored items.
  Future<List<Map<String, dynamic>>> readAll(String table);

  /// Deletes an item from the storage based on the specified table and key.
  ///
  /// [table] - The name of the table to search in.
  /// [key] - The key used to identify the item to delete.
  Future<void> delete(String table, String key);

  /// Clears all items from the specified table.
  ///
  /// [table] - The name of the table to clear.
  Future<void> clear(String table);
}
