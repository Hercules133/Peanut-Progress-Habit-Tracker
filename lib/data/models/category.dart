class Category {
  String _name;
  String _color; // (Hex code?)
  // Optional, a description (?)

  Category({required String name, required String color})
      : _color = color,
        _name = name;
}
