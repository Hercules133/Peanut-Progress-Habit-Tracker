import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/widgets/app_bar_widget.dart';
import 'package:streaks/core/widgets/drawer_menu_widget.dart';

import 'switch_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final switchState = Provider.of<SwitchState>(context, listen: false);

    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
        appBarTitle: 'Settings',
      ),
      drawer: const MyDrawerMenu(),
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(
                Icons.person_outline,
                size: 55.0,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Username"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Type in your name",
                fillColor: Colors.white70,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Languages"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 365,
              child: DropdownMenu(
                key: ValueKey("dropdown1"),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                width: 365,
                label: Text('Language'),
                dropdownMenuEntries: <DropdownMenuEntry<String>>[
                  DropdownMenuEntry(value: 'Deutsch', label: 'Deutsch'),
                  DropdownMenuEntry(value: 'English', label: 'English')
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text("Cloud"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "None",
                fillColor: Colors.white70,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("Theme Mode"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: 365,
              child: DropdownMenu(
                key: const ValueKey("dropdown2"),
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                width: 365,
                label: const Text('Theme'),
                initialSelection: _getInitialSelection(switchState.themeMode),
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
        ],
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
