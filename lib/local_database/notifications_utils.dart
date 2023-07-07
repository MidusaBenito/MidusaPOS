import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class notificationDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'notificationData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setNotificationData(
      List<Map<String, dynamic>> notification_Details) async {
    String jsonString = json.encode(notification_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getNotificationData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> notificationDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return notificationDetails;
    }
    return null;
  }
}
