import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class customerDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'customerData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setCustomerData(
      List<Map<String, dynamic>> customer_Details) async {
    String jsonString = json.encode(customer_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getCustomerData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> customerDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return customerDetails;
    }
    return null;
  }
}
