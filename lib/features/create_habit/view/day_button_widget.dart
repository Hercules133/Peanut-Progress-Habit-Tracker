import 'package:flutter/material.dart';

class DayButtonWidget extends StatelessWidget {
  const DayButtonWidget({super.key, required this.day});

  final String day;  

   @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(day)); 
  
  }



}