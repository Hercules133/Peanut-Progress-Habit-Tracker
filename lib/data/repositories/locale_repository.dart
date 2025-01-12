import '/services/storage/storage_service.dart';
import '/core/config/locator.dart';

class LocaleRepository {
  final StorageService _storageService = locator<StorageService>();

  Future<String> getLocale() async {
    Map<String, dynamic>? locale = await _storageService.read('languageCode', 'languageCode');
    return locale?['languageCode'] ?? 'en';
  }

  Future<void> saveLocale(String locale) async {
    await _storageService.save('languageCode', {'languageCode': locale}, (data) => 'languageCode');
  }
}
