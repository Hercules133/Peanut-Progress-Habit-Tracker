import 'package:flutter/material.dart';
import 'package:peanutprogress/data/repositories/username_repository.dart';

/// A provider class that manages the application's username. It extends
/// [ChangeNotifier] to notify listeners when the username is updated.
class UsernameProvider extends ChangeNotifier {
  String _username = '';
  final UsernameRepository _usernameRepository = UsernameRepository();
  final TextEditingController _controller = TextEditingController();

  /// The current username of the user.
  String get username => _username;
  UsernameRepository get usernameRepository => _usernameRepository;
  TextEditingController get controller => _controller;

  /// Fetches the stored username from the [UsernameRepository] and updates
  /// the [_username] state. Also updates the [TextEditingController]'s text to
  /// the fetched username.
  /// Notifies listeners when the username is fetched.
  Future<void> fetchUsername() async {
    _username = await _usernameRepository.getUsername();
    _controller.text = _username;
    notifyListeners();
  }

  /// Saves the provided username to the [UsernameRepository] and updates the
  /// [_username] state.
  ///
  /// [username] - The username to save.
  Future<void> saveUsername(String username) async {
    await _usernameRepository.saveUsername(username);
    _username = username;
    notifyListeners();
  }

  /// Updates the username from the [TextEditingController] and saves it to the
  /// repository.
  void updateFromController() {
    saveUsername(_controller.text);
  }
}
