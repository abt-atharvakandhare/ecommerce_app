import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessToken = 'Access_Token';

  static Future<void> saveAccessToken(String token) async {
    try {
      await _storage.write(key: _accessToken, value: token);
    } catch (e) {
      debugPrint('TokenStorage saveAccessToken error: $e');
    }
  }

  static Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessToken);
    } catch (e) {
      debugPrint('TokenStorage getAccessToken error: $e');
      return null;
    }
  }

  static Future<void> clearToken() async {
    try {
      await _storage.delete(key: _accessToken);
    } catch (e) {
      debugPrint('TokenStorage clearToken error: $e');
    }
  }
}