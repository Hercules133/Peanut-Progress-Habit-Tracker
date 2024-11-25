import 'package:flutter/material.dart';

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
                  onTap: () {},
                ),
                ListTile(
                  leading: const ImageIcon(AssetImage('assets/images/Erdnuss.png'),),
                  title: const Text('Habits'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.signal_cellular_alt),
                  title: const Text('Statistics'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {},
                ),
              ],
            ),
          
          );
  }
}
