import 'package:flutter/material.dart';
import 'package:peanutprogress/data/repositories/locale_repository.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  final LocaleRepository _localeRepository = LocaleRepository();

  Locale? get locale => _locale;

  Future<void> fetchLocale() async {
    String locale = await _localeRepository.getLocale();
    _locale = Locale(locale);
    notifyListeners();
  }

  Future<void> saveLocale(String locale) async {
    await _localeRepository.saveLocale(locale);
    _locale = Locale(locale);
    notifyListeners();
  }
}
