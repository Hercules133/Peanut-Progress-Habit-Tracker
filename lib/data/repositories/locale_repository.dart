import 'package:peanutprogress/services/storage/storage_service.dart';
import 'package:peanutprogress/core/config/locator.dart';

/// A repository class responsible for interacting with the storage layer
/// to persist and retrieve the locale setting of the application.
class LocaleRepository {
  final StorageService _storageService = locator<StorageService>();

  /// Retrieves the stored locale from the storage.
  /// If no locale is found, it defaults to 'en' (English).
  ///
  /// Returns the stored locale as a [String].
  Future<String> getLocale() async {
    Map<String, dynamic>? locale =
        await _storageService.read('languageCode', 'languageCode');
    return locale?['languageCode'] ?? 'en';
  }

  /// Saves the provided locale to the storage.
  ///
  /// [locale] - The locale to save.
  Future<void> saveLocale(String locale) async {
    await _storageService.save(
        'languageCode', {'languageCode': locale}, (data) => 'languageCode');
  }
}
