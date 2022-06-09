import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsProvider extends ChangeNotifier {
  late SharedPreferences sharedPreferences;
  Map<String, dynamic> settings = {};

  void getUserSettings() async {
    sharedPreferences = await SharedPreferences.getInstance();
    settings = jsonDecode(sharedPreferences.getString('user_settings') ?? '{}');

    notifyListeners();
  }

  void addSetting(String setting, dynamic value) async {
    settings[setting] = value;
    await sharedPreferences.setString('user_settings', jsonEncode(settings));
    notifyListeners();
  }
}
