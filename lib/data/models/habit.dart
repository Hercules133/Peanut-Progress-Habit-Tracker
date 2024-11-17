// ignore_for_file: unnecessary_getters_setters

class Habit {
  String _title;
  String _description;
  List<DateTime> _time;
  bool _isCompleted;
  String _category;

  // habbit id
  // category -> enum, seperate class
  // time -> days and time
  // iscompleted (days?)

  Habit({
    required String title,
    required String description,
    required List<DateTime> time,
    bool isCompleted = false,
    required String category,
  })  : _title = title,
        _description = description,
        _time = time,
        _isCompleted = isCompleted,
        _category = category;

  // Getter for title
  String get title => _title;

  // Setter for title
  set title(String value) {
    if (value.isEmpty) {
      throw ArgumentError("You must specify a title!");
    }
    _title = value;
  }

  // Getter for description
  String get description => _description;

  // Setter for description
  set description(String value) {
    if (value.length > 150) {
      throw ArgumentError("Description cannot be longer then 150 characters!");
    }
    _description = value;
  }

  // Getter for time
  List<DateTime> get time => _time;

  // Setter for time
  set time(List<DateTime> value) {
    if (value.isEmpty) {
      throw ArgumentError("You have to choose a time!");
    }
    _time = value;
  }

  // Getter for isCompleted
  bool get isCompleted => _isCompleted;

  // Setter for isCompleted
  set isCompleted(bool value) {
    _isCompleted = value;
  }

  // Getter for category
  String get category => _category;

  // Setter for category
  set category(String value) {
    if (value.isEmpty) {
      throw ArgumentError("YOu have to choose a category!");
    }
    _category = value;
  }
}
