import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class categoryDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'categoryData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setCategoryData(
      List<Map<String, dynamic>> category_Details) async {
    String jsonString = json.encode(category_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getCategoryData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> categoryDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return categoryDetails;
    }
    return null;
  }
}
