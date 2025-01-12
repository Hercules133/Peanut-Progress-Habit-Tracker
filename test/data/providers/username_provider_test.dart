import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/data/providers/username_provider.dart';
import 'package:provider_test/provider_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });
  testProvider<UsernameProvider>(
    "Constructor should initialize correctly",
      build: () => UsernameProvider(),
      verify: (provider) {
        expect(provider.username, '');
        expect(provider.controller.text, '');
      });
  

    testProvider(
    "saveUsername should set a new username",
     build: ()=> UsernameProvider(),
      act: (provider) => provider.saveUsername('Test'),
      verify: (provider) {
        Future<String> username = provider.usernameRepository.getUsername();  
        expect(username,completion(equals('Test')));
        expect(provider.username, 'Test');
      },
  );
  

  testProvider<UsernameProvider>(
    "fetchUsername should update the username and controller",
    build: () => UsernameProvider(),
    seed:(provider) => provider.usernameRepository.saveUsername('Test'),
    act: (provider) => provider.fetchUsername(),
    verify: (provider) {
      expect(provider.username, 'Test');
      expect(provider.controller.text, 'Test');
    },
  );

  testProvider<UsernameProvider>(
    "updateFromController should update the username",
    build: () => UsernameProvider(),
    seed: (provider) => provider.controller.text = 'Test',
    act: (provider) => provider.updateFromController(),
    verify: (provider) {
      expect(provider.username, 'Test');
    },
  );
}