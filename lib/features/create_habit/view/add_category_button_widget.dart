import 'package:flutter/material.dart';

class AddCategoryButtonWidget extends StatelessWidget {
  const AddCategoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.add,
      ),
      tooltip: "Add Category",
      onPressed: () {},
    );
  }
}