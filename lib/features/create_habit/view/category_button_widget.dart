import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({super.key, required this.category, required this.color});

  final String category;  
  final Color color; 

   @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () {},
      child: Text(category)); 
  
  }



}