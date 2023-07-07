import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class productDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'productData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setProductData(
      List<Map<String, dynamic>> product_Details) async {
    String jsonString = json.encode(product_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getProductData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> productDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return productDetails;
    }
    return null;
  }
}
