import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/widgets/app_bar_widget.dart';
import '/core/widgets/drawer_menu_widget.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 55.0,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Username"),
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: "Type in your name",
                                ),
                                cursorColor:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Languages"),
                              DropdownButton<String>(
                                value: 'English',
                                onChanged: (String? newValue) {},
                                items: const <DropdownMenuItem<String>>[
                                  DropdownMenuItem<String>(
                                    value: 'English',
                                    child: Text('English'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Deutsch',
                                    child: Text('Deutsch'),
                                  ),
                                ],
                                isExpanded: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Cloud"),
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: "none",
                                ),
                                cursorColor:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Theme Mode"),
                              DropdownButton<String>(
                                value:
                                    _getInitialSelection(switchState.themeMode),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    switch (newValue) {
                                      case 'dark':
                                        switchState
                                            .toggleThemeMode(ThemeMode.dark);
                                        break;
                                      case 'light':
                                        switchState
                                            .toggleThemeMode(ThemeMode.light);
                                        break;
                                      case 'system':
                                        switchState
                                            .toggleThemeMode(ThemeMode.system);
                                        break;
                                    }
                                  }
                                },
                                items: const <DropdownMenuItem<String>>[
                                  DropdownMenuItem<String>(
                                    value: 'dark',
                                    child: Text('Dark'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'light',
                                    child: Text('Light'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'system',
                                    child: Text('System'),
                                  ),
                                ],
                                isExpanded: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
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
                    decoration: const InputDecoration(
                      hintText: "Type in your name",
                    ),
                    cursorColor: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("Languages"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: 'English',
                      onChanged: (String? newValue) {},
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: 'English',
                          child: Text('English'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Deutsch',
                          child: Text('Deutsch'),
                        ),
                      ],
                      isExpanded: true,
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
                    decoration: const InputDecoration(
                      hintText: "none",
                    ),
                    cursorColor: Theme.of(context).colorScheme.onSurface,
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
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: _getInitialSelection(switchState.themeMode),
                      onChanged: (String? newValue) {
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
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: 'dark',
                          child: Text('Dark'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'light',
                          child: Text('Light'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'system',
                          child: Text('System'),
                        ),
                      ],
                      isExpanded: true,
                    ),
                  ),
                ),
              ],
            );
          }
        },
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
