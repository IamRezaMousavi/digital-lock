import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  SharedPreferences? _prefs;

  final String key = 'isDark';
  late bool _darktheme;
  bool get darktheme => _darktheme;

  Color _themecolor = Colors.green;
  Color get themecolor => _themecolor;

  AppTheme() {
    _loadprefs();
  }

  void tagglethememode() {
    _darktheme = !_darktheme;
    _saveprefs();
    notifyListeners();
  }

  void changeThemeColor(Color newColor) {
    _themecolor = newColor;
    notifyListeners();
  }

  _initprefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadprefs() async {
    await _initprefs();
    _darktheme = _prefs?.getBool(key) ?? true;
    notifyListeners();
  }

  _saveprefs() async {
    await _initprefs();
    await _prefs?.setBool(key, _darktheme);
  }
}
