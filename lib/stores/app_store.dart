import 'dart:async';

import 'package:flutter/material.dart';

class AppStore extends ChangeNotifier {
  bool isDarkTheme = false;
  String errorMessage = '';

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      errorMessage = '';
      notifyListeners();
    });
  }

  void changeTheme(bool value) {
    isDarkTheme = value;
    notifyListeners();
  }
}
