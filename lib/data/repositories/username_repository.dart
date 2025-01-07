import '/services/storage/storage_service.dart';
import '/core/config/locator.dart';

class UsernameRepository {
  final StorageService _storageService = locator<StorageService>();

  Future<String> getUsername() async {
    Map<String, dynamic>? username =
        await _storageService.read('username', 'username');
    return username?['username'] ?? '';
  }

  Future<void> saveUsername(String username) async {
    await _storageService.save(
        'username', {'username': username}, (data) => 'username');
  }
}
