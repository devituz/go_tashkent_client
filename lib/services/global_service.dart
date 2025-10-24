import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/screens/login/page/login.dart';
import 'package:go_tashkent_client/services/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class GlobalService {
  final Dio dio;
  String? token;

  GlobalService({this.token, String baseUrl = 'https://gotoshkent.uz/api/'})
      : dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 20),      // jo‘natish uchun 20s
    receiveTimeout: const Duration(seconds: 60),
    headers: {'Accept': 'application/json'},
  )) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) {},
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          print("Token $token");
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // print(response);
        return handler.next(response);
      },
      onError: (e, handler) {
        print(e);
        return handler.next(e);

      },
    ));
  }

  Map<String, dynamic> handleResponse(Response response) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      return response.data;

    } else if (status >= 400 && status < 500) {
      throw Exception('Client Error: $status');
    } else if (status >= 500 && status < 600) {
      throw Exception('Server Error: $status');
    } else {
      throw Exception('Unknown Error: $status');
    }
  }

  Exception handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('So‘rov vaqti tugadi, qayta urinib ko‘ring');

      case DioExceptionType.badResponse:
        final res = e.response;
        if (res != null) {

          if (res.statusCode == 401) {
            globalLogout();
          }

          if (res.data is Map<String, dynamic>) {
            final data = res.data as Map<String, dynamic>;

            if (data['status'] == 'wait') {
              return ApiException(data['message'] ?? 'Iltimos, 1 minut kuting.');
            }

            if (data['status'] == 'search_error') {
              return ApiException(data['message'] ?? 'Natija topilmadi.');
            }



            if (data['status'] == 'notfound_user') {
              return ApiException(
                data['message'] ?? 'Bunday foydalanuvchi yo‘q',
                status: 'notfound_user',
              );
            }

            if (data['status'] == 'sms_code_error') {
              return ApiException(
                data['message'] ?? 'SMS kodi noto‘g‘ri',
                status: 'sms_code_error',
              );
            }

            if (data['status'] == 'only_one_restaurant') {
              return ApiException(
                data['message'] ?? "Siz faqat bitta restoran mahsulotlarini basketga qo‘sha olasiz. Savatni tozalashni xohlaysizmi",
                status: 'only_one_restaurant',
              );
            }

            if (data['status'] == 'code_expired') {
              return ApiException(
                data['message'] ?? 'SMS kodi muddati tugagan',
                status: 'code_expired',
              );
            }

            if (data['status'] == 'cencel_error') {
              return ApiException(
                data['message'] ?? 'xato',
                status: 'cencel_error',
              );
            }

            if (data['status'] == 'ok') {
              return ApiException(
                data['message'] ?? 'Tasdiqlandi',
                status: 'ok',
              );
            }
          }
        }
        return ApiException('Xatolik yuz berdi keyinroq qayta uruning!');
        default:
        return ApiException('Xatolik yuz berdi keyinroq qayta uruning!');
    }
  }

}

class ApiException implements Exception {
  final String message;
  final String? status;

  ApiException(this.message, {this.status});

  @override
  String toString() => message;
}


Future<void> globalLogout() async {
  final prefs = await SharedPreferences.getInstance();
  final auth = prefs.getBool('auth') ?? true;

  // 🔹 Agar foydalanuvchi mehmon bo‘lsa, tokenni o‘chirmasdan chiqamiz
  if (auth == false) {
    debugPrint('⚠️ Mehmon foydalanuvchi, logout qilinmadi.');
    return;
  }

  // 🔹 Aks holda — tokenni tozalaymiz va login sahifasiga qaytamiz
  await TokenStorage.removeToken();

  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
  );

  debugPrint('✅ Logout muvaffaqiyatli bajarildi.');
}

String get currentLang {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) {
    // fallback til — agar kontekst yo‘q bo‘lsa, 'ru' qaytaradi
    return 'ru';
  }
  // easy_localization orqali hozirgi tanlangan tilni olish
  return EasyLocalization.of(ctx)!.locale.languageCode;
}