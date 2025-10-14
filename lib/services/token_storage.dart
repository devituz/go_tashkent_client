import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _tokenKey = "auth_token";

  /// 🔑 Token qo‘shish yoki yangilash
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// 📥 Tokenni olish
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);

  }

  /// ❌ Tokenni o‘chirish
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);

  }

  /// 🔍 Token mavjudligini tekshirish
  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }
}




// // Token olish
// String? token = await TokenStorage.getToken();
//
// // Token mavjudligini tekshirish
// bool isLoggedIn = await TokenStorage.hasToken();
//
// // Token o‘chirish (logout uchun)
// await TokenStorage.removeToken();
