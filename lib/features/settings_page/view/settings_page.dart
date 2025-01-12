import 'package:flutter/material.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import 'package:peanutprogress/data/providers/username_provider.dart';
import 'package:provider/provider.dart';
import '/core/widgets/app_bar_widget.dart';
import '/core/widgets/drawer_menu_widget.dart';
import 'package:peanutprogress/core/config/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'switch_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final switchState = Provider.of<SwitchState>(context, listen: false);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final usernameProvider = Provider.of<UsernameProvider>(context);

    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
        appBarTitle: AppLocalizations.of(context)!.settingsPageAppBarTitle,
      ),
      drawer: const MyDrawerMenu(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.person_outline,
                  size: 55.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(AppLocalizations.of(context)!.settingsPageUsername),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.settingsPageNameHintText,
                ),
                controller: usernameProvider.controller,
                onChanged: (value) {
                  usernameProvider.updateFromController();
                },
                cursorColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child:
                    Text(AppLocalizations.of(context)!.settingsPageLanguages),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: DropdownMenuTheme(
                  data: DropdownMenuThemeData(
                    menuStyle: MenuStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the border radius
                        ),
                      ),
                    ),
                  ),
                  child: DropdownMenu(
                    inputDecorationTheme:
                        const InputDecorationTheme(filled: true),
                    initialSelection: localeProvider.locale?.languageCode,
                    trailingIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    width: double.infinity,
                    dropdownMenuEntries:
                        Language.languageList().map((language) {
                      return DropdownMenuEntry<String>(
                        value: language.languageCode,
                        label: '${language.flag} ${language.name}',
                      );
                    }).toList(),
                    onSelected: (languageCode) {
                      localeProvider.saveLocale(languageCode!);
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text(AppLocalizations.of(context)!.settingsPageCloud),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "none",
                ),
                cursorColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child:
                    Text(AppLocalizations.of(context)!.settingsPageThemeMode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: DropdownMenuTheme(
                  data: DropdownMenuThemeData(
                    menuStyle: MenuStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the border radius
                        ),
                      ),
                    ),
                  ),
                  child: DropdownMenu(
                    inputDecorationTheme:
                        const InputDecorationTheme(filled: true),
                    width: double.infinity,
                    initialSelection:
                        _getInitialSelection(switchState.themeMode),
                    dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(value: 'dark', label: 'Dark'),
                      DropdownMenuEntry(value: 'light', label: 'Light'),
                      DropdownMenuEntry(value: 'system', label: 'System')
                    ],
                    onSelected: (String? newValue) {
                      if (newValue != null) {
                        switch (newValue) {
                          case 'dark':
                            switchState.toggleThemeMode(ThemeMode.dark);
                            break;
                          case 'light':
                            switchState.toggleThemeMode(ThemeMode.light);
                            break;
                          case 'system':
                            switchState.toggleThemeMode(ThemeMode.system);
                            break;
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getInitialSelection(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.light:
      return 'light';
    case ThemeMode.system:
      return 'system';
  }
}
