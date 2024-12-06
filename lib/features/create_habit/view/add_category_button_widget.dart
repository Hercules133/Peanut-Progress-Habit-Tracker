import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/popup_create_category.dart';

class AddCategoryButtonWidget extends StatelessWidget {
  const AddCategoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add,
      ),
      tooltip: "Add Category",
      onPressed: () {
        popupCreateCategory(context);
      },
    );
  }
}
