import 'package:flutter/material.dart';


class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      tooltip: "Delete",
      onPressed: () {},
    );
  }
}
