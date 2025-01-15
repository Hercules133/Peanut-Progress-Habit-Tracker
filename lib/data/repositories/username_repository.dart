import 'package:peanutprogress/services/storage/storage_service.dart';
import 'package:peanutprogress/core/config/locator.dart';

/// A repository class responsible for interacting with the storage layer
/// to persist and retrieve the username.
class UsernameRepository {
  final StorageService _storageService = locator<StorageService>();

  /// Retrieves the stored username from the storage.
  /// If no username is found, an empty string is returned.
  ///
  /// Returns the stored username as a [String]. Defaults to an empty string if
  /// not found.
  Future<String> getUsername() async {
    Map<String, dynamic>? username =
        await _storageService.read('username', 'username');
    return username?['username'] ?? '';
  }

  /// Saves the provided username to the storage.
  ///
  /// [username] - The username to save.
  Future<void> saveUsername(String username) async {
    await _storageService.save(
        'username', {'username': username}, (data) => 'username');
  }
}
