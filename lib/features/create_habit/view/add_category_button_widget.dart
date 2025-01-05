import 'package:flutter/material.dart';
import '/features/create_habit/view/popup_create_category.dart';

class AddCategoryButtonWidget extends StatelessWidget {
  const AddCategoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      tooltip: "Add Category",
      onPressed: () {
        popupCreateCategory(context);
      },
    );
  }
}
