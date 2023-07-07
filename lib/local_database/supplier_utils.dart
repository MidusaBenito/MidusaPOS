import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class supplierDetailsPreference {
  static late SharedPreferences _preferences;
  static const _keyUserData = 'supplierData';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setSupplierData(
      List<Map<String, dynamic>> supplier_Details) async {
    String jsonString = json.encode(supplier_Details);
    await _preferences.setString(_keyUserData, jsonString);
  }

  //get data
  static List<Map<String, dynamic>>? getSupplierData() {
    String? jsonString = _preferences.getString(_keyUserData.toString());
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, dynamic>> supplierDetails = decodedList
          .map((dynamic item) => item as Map<String, dynamic>)
          .toList();
      return supplierDetails;
    }
    return null;
  }
}
