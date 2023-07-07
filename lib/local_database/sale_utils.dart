import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class saleDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'saleData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setSaleData(List<Map<String, dynamic>> sale_Details) async {
    String jsonString = json.encode(sale_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getSaleData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> saleDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return saleDetails;
    }
    return null;
  }
}
