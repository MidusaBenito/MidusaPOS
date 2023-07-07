import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class pausedCartDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'pausedCartData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setPausedCartData(
      List<Map<String, dynamic>> pausedCart_Details) async {
    String jsonString = json.encode(pausedCart_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getPausedCartData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> pausedCartDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return pausedCartDetails;
    }
    return null;
  }
}
