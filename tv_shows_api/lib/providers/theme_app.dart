import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  AppThemeProvider();

  ThemeMode get themeMode => _themeMode;

  void switchMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
