import 'package:flutter/material.dart';
import '/features/create_habit/view/delete_button_widget.dart';
import '/features/create_habit/view/close_button_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.appBar, required this.newHabit});
  final AppBar appBar;
  final bool newHabit;
  @override
  Widget build(BuildContext context) {
    return AppBar(leading: const CloseButtonWidget(), actions: <Widget>[
      if (newHabit == false) DeleteButtonWidget(),
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
