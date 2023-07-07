import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class stockPurchaseInventoryPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'stockInventory';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setStockPurchaseInventory(
      List<Map<String, dynamic>> stock_Inventory) async {
    String jsonString = json.encode(stock_Inventory);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getStockPurchaseInventory() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> stockPurchaseInventory = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return stockPurchaseInventory;
    }
    return null;
  }
}
