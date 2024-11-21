import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.appBar});

  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(getGreeting()),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        IconButton(
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {}),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 18) {
      return 'Hello!';
    } else if (hour >= 18 && hour < 22) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }
}
