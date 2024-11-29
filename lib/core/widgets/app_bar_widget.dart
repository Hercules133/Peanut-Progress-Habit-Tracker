import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.appBar, required this.appBarTitle});
  final AppBar appBar;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
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
            onPressed: null),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

}
