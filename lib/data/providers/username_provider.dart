import 'package:flutter/material.dart';
import 'package:peanutprogress/data/repositories/username_repository.dart';

class UsernameProvider extends ChangeNotifier {
  String _username = '';
  final UsernameRepository _usernameRepository = UsernameRepository();
  final TextEditingController _controller = TextEditingController();

  String get username => _username;
  UsernameRepository get usernameRepository => _usernameRepository;
  TextEditingController get controller => _controller;

  Future<void> fetchUsername() async {
    _username = await _usernameRepository.getUsername();
    _controller.text = _username;
    notifyListeners();
  }

  Future<void> saveUsername(String username) async {
    await _usernameRepository.saveUsername(username);
    _username = username;
    notifyListeners();
  }

  void updateFromController() {
    saveUsername(_controller.text);
  }
}
