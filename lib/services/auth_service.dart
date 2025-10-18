import 'package:dio/dio.dart';
import 'package:go_tashkent_client/helper/payload_helper.dart';
import 'package:go_tashkent_client/model/User_models.dart';
import 'package:go_tashkent_client/services/global_service.dart';

class AuthService {
  final GlobalService _globalService;

  AuthService({GlobalService? globalService})
      : _globalService = globalService ?? GlobalService();

  Future<Map<String, dynamic>> login({
    required String phone,
    String lang = 'uz',
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        'phone': phone,
        ...payload,
      });

      final response = await _globalService.dio.post(
        'mobile-client/login',
        data: formData,
        queryParameters: {'lang': lang},
      );

      return _globalService.handleResponse(response);
    } on DioException catch (e) {
      throw _globalService.handleDioError(e);
    }
  }




  Future<Map<String, dynamic>> register({
    required String firstName,
    required String phone,
    String lang = 'uz',
  }) async {
    try {

      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        'firstname': firstName,
        'phone': phone,
        ...payload,

      });

      final response = await _globalService.dio.post(
        'mobile-client/register',
        data: formData,
        queryParameters: {'lang': lang},
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      return _globalService.handleResponse(response);
    } on DioException catch (e) {
      throw _globalService.handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String code,
    String lang = 'uz',
  }) async {
    try {

      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        'phone': phone,
        'code': code,
        ...payload,

      });

      final response = await _globalService.dio.post(
        'mobile-client/verify-code',
        data: formData,
        queryParameters: {'lang': lang},
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      return _globalService.handleResponse(response);
    } on DioException catch (e) {
      throw _globalService.handleDioError(e);
    }
  }


  Future<User> clientUser({
    String lang = 'ru',
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        ...payload,
      });

      final response = await _globalService.dio.post(
        'mobile-client/user-profile',
        data: formData,
        queryParameters: {'lang': lang},
      );

      final data = _globalService.handleResponse(response);

      // 🔑 JSON → model
      print("object  ${data}");
      return User.fromJson(data);

    } on DioException catch (e) {
      print("object xato ${e}");
      throw _globalService.handleDioError(e);
    }
  }

  Future<void> deleteClientUser({
    String lang = 'ru',
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final response = await _globalService.dio.delete(
        'mobile-client/delete',
        data: payload,
        queryParameters: {'lang': lang},
      );

      final data = _globalService.handleResponse(response);
      print('✅ User delete response: $data');

    } on DioException catch (e) {
      print('❌ Delete xato: $e');
      throw _globalService.handleDioError(e);
    }
  }




}
