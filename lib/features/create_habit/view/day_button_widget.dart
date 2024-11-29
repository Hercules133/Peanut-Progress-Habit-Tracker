import 'package:flutter/material.dart';

class DayButtonWidget extends StatelessWidget {
  DayButtonWidget({super.key, required this.day});

  final String day;
  final ValueNotifier<bool> _hasBeenPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
            // onPressed: () {},
            style: ButtonStyle(
              backgroundColor: _hasBeenPressed.value
                  ? const WidgetStatePropertyAll<Color>(Colors.blue)
                  : const WidgetStatePropertyAll<Color>(Colors.white),
            ),
            onPressed: () {_hasBeenPressed.value = !_hasBeenPressed.value;},
            child: Text(day),
          );
        });
  }
}
