import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import 'package:provider_test/provider_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });  

    testProvider(
    "saveLocale should set a new locale",
      build: ()=> LocaleProvider(),
      act: (provider) => provider.saveLocale('de'),
      verify: (provider) {
        Future<String> locale = provider.localeRepository.getLocale();
        expect(locale, completion(equals('de')));
        expect(provider.locale?.languageCode, 'de');
      },
  );
  

  testProvider<LocaleProvider>(
    "fetchLocale should update the locale",
    build: () => LocaleProvider(),
    seed:(provider) => provider.localeRepository.saveLocale('de'),
    act: (provider) => provider.fetchLocale(),
    verify: (provider) {
      expect(provider.locale, Locale('de'));
    },
  );

}