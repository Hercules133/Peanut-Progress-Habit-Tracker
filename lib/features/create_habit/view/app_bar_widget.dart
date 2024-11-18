import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/delete_button_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarWidget({super.key, required this.appBar});
  final AppBar appBar; 

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: const CloseButton(), 
        actions: const <Widget>[
          DeleteButtonWidget(), 
        ]);
  }

   @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
