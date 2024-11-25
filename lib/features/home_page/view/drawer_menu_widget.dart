import 'package:flutter/material.dart';
import 'package:streaks/core/utils/routes.dart';

class MyDrawerMenu extends StatelessWidget {
  const MyDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage('assets/images/Erdnuss.png'),
            ),
            title: const Text('Habits'),
            onTap: () {
              // Navigator.pushReplacementNamed(context, Routes.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.signal_cellular_alt),
            title: const Text('Statistics'),
            onTap: () {
              // Navigator.pushReplacementNamed(context, Routes.statistics);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigator.pushReplacementNamed(context, Routes.settings);
            },
          ),
        ],
      ),
    );
  }
}
