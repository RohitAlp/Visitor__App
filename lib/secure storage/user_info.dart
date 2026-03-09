import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/VerifyOtpResponse.dart';

class UserInfoSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyUserInfo = 'user_info';

  // Save full login response
  static Future<void> saveUserInfo(VerifyOtpResponse user) async {
    final jsonString = jsonEncode(user.toJson());
    await _storage.write(key: _keyUserInfo, value: jsonString);
  }

  // Get full login response
  static Future<VerifyOtpResponse?> getUserInfo() async {
    final jsonString = await _storage.read(key: _keyUserInfo);
    if (jsonString != null) {
      return VerifyOtpResponse.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // Get token specifically
  static Future<String?> getToken() async {
    final user = await getUserInfo();
    return user?.token;
  }

  // Clear all stored user info
  static Future<void> clearUserInfo() async {
    await _storage.delete(key: _keyUserInfo);
  }
}
