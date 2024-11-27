import 'package:flutter/material.dart';

class DescriptionFormfieldWidget extends StatelessWidget {
  const DescriptionFormfieldWidget({super.key, required this.descriptionController});

  final TextEditingController descriptionController; 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 150,
        controller: descriptionController,
        decoration: const InputDecoration(
          labelText: "description (optional) ",
          hintText: "Enter a description",
        ),
        validator: (value) {
          return ("Enter description");
          // value == null || value.isEmpty)
          // ? "Enter task"
          // : model.getTask(index).title;
        },
        onChanged: (value) {
          // model.getTask(index).title = value;
          // model.saveData(storageForm);
        });
  }
}
