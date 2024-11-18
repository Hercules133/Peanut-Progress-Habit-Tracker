import 'package:flutter/material.dart';

Future<void>  popupSavingWidget(BuildContext context) async {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save'),
          content: Row(children: [
            IconButton(
              onPressed: () {
                 Navigator.pop(context);
              }, 
              icon: const Icon(Icons.check),
            ),
             IconButton(
              onPressed: () {
                 Navigator.pop(context);
              }, 
              icon: const Icon(Icons.close),
            ),
          ]),
        );
      });
  }
