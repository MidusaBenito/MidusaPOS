import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class shoppingCartDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'shoppingCartData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setshoppingCartData(
      List<Map<String, dynamic>> shoppingCart_Details) async {
    String jsonString = json.encode(shoppingCart_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getshoppingCartData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> shoppingCartDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return shoppingCartDetails;
    }
    return null;
  }
}
