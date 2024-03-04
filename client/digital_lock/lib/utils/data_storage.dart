import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage extends ChangeNotifier {
  SharedPreferences? _prefs;

  final String phoneNumberKey = 'phoneNumber';
  late String _phoneNumber;
  String get phoneNumber => _phoneNumber;

  DataStorage() {
    _loadprefs();
  }

  setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    _saveprefs();
    notifyListeners();
  }

  _initprefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadprefs() async {
    await _initprefs();
    _phoneNumber = _prefs?.getString(phoneNumberKey) ?? "";
    notifyListeners();
  }

  _saveprefs() async {
    await _initprefs();
    _prefs?.setString(phoneNumberKey, _phoneNumber);
  }
}
