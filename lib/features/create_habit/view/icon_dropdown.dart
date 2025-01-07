import 'package:flutter/material.dart';

class IconDropdown extends StatelessWidget {
  final IconData selectedIcon;
  final ValueChanged<IconData> onIconChanged;

  const IconDropdown({
    super.key,
    required this.selectedIcon,
    required this.onIconChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.onSurface;
    return DropdownButton<IconData>(
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      menuMaxHeight: 250,
      menuWidth: 65,
      value: selectedIcon,
      items: [
        DropdownMenuItem(
          value: Icons.star,
          child: Icon(Icons.star, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.favorite,
          child: Icon(Icons.favorite, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.home,
          child: Icon(Icons.home, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.desktop_mac,
          child: Icon(Icons.desktop_mac, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.menu_book,
          child: Icon(Icons.menu_book, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.fitness_center,
          child: Icon(Icons.fitness_center, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.music_note,
          child: Icon(Icons.music_note, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.nightlight,
          child: Icon(Icons.nightlight, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.psychology,
          child: Icon(Icons.psychology, color: iconColor),
        ),
        DropdownMenuItem(
          value: Icons.school,
          child: Icon(Icons.school, color: iconColor),
        )
      ],
      onChanged: (IconData? newValue) {
        if (newValue != null) {
          onIconChanged(newValue);
        }
      },
    );
  }
}
