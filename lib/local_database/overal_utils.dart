import 'package:shared_preferences/shared_preferences.dart';

class overalDataPreference {
  static late SharedPreferences _preferences;
  static const _keyAdminCreated = 'adminCreated';
  static const _keySerialNumberSet = 'serialNumberSet';
  static const _keySerialNumber = 'serialNumber';
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future setAdminCreatedStatus(bool adminCreated) async =>
      await _preferences.setBool(_keyAdminCreated, adminCreated);
  static Future setSerialNumberSet(bool serialNumberSet) async =>
      await _preferences.setBool(_keySerialNumberSet, serialNumberSet);
  static Future setSerialNumber(String serialNumber) async =>
      await _preferences.setString(_keySerialNumberSet, serialNumber);
  //get data
  static bool? getAdminCreatedStatus() =>
      _preferences.getBool(_keyAdminCreated);
  static bool? getSerialNumberSet() =>
      _preferences.getBool(_keySerialNumberSet);
  static String? getSerialNumber() => _preferences.getString(_keySerialNumber);
}
