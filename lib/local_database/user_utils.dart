import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class userDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'userData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setUserData(List<Map<String, dynamic>> user_Details) async {
    String jsonString = json.encode(user_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getUserData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> userDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return userDetails;
    }
    return null;
  }
}
