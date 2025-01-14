import 'package:flutter/material.dart';
import 'package:peanutprogress/data/repositories/locale_repository.dart';

/// A provider class that manages the app's locale settings.
/// It extends [ChangeNotifier] to notify listeners when the locale changes.
class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  final LocaleRepository _localeRepository = LocaleRepository();

  /// The current locale of the application.
  Locale? get locale => _locale;

  /// Fetches the stored locale from the [LocaleRepository] and updates the
  /// [locale] state. Notifies listeners when the locale is fetched.
  Future<void> fetchLocale() async {
    String locale = await _localeRepository.getLocale();
    _locale = Locale(locale);
    notifyListeners();
  }

  /// Saves the provided locale to the [LocaleRepository] and updates the
  /// [locale] state.
  ///
  /// [locale] - The locale to save.
  Future<void> saveLocale(String locale) async {
    await _localeRepository.saveLocale(locale);
    _locale = Locale(locale);
    notifyListeners();
  }
}
