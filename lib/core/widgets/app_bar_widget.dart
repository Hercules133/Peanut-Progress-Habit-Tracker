import 'package:flutter/material.dart';

/// A custom app bar that displays a title , the app icon and a menu icon.
///
/// The [appBar] parameter is the [AppBar] widget to be customized.
/// The [appBarTitle] parameter is the text to be displayed in the app bar,
/// which can be the page title or a personalized greeting.
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.appBar, required this.appBarTitle});
  final AppBar appBar;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            icon: Image.asset('assets/images/logo.png'), onPressed: null),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
