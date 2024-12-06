import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/widgets/app_bar_widget.dart';
import 'package:streaks/core/widgets/drawer_menu_widget.dart';

import 'switch_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final switchState = Provider.of<SwitchState>(context);
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
                inputDecorationTheme: const InputDecorationTheme(
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
          Text(
            'Theme is ${switchState.isDarkMode ? "Dark" : "Light"}',
            style: TextStyle(fontSize: 20),
          ),
          Switch(
            value: switchState.isDarkMode,
            onChanged: (value) {
              switchState.toggleSwitch(value);
            },
            activeTrackColor: Colors.black,
            activeColor: Colors.grey,
            inactiveTrackColor: Colors.white,
            inactiveThumbColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
