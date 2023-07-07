import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'dart:math';

///Accepts encrypted data and decrypt it. Returns plain text
String decryptMyEncryption(String key, String encryptedData) {
  Encrypted passW = Encrypted.fromBase64(encryptedData);
  final myKey = Key.fromUtf8(key.substring(0, min(key.length, 32)));
  final encrypter = Encrypter(AES(myKey));
  final iv = IV.fromLength(16);
  final decrypted = encrypter.decrypt(passW, iv: iv);
  return decrypted;
}

///Encrypts the given plainText using the key. Returns encrypted data
Encrypted createMyEncryption(String key, String plainText) {
  final myKey = Key.fromUtf8(key.substring(0, min(key.length, 32)));
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(myKey));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted;
}
