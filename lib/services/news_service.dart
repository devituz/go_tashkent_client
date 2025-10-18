import 'package:dio/dio.dart';
import 'package:go_tashkent_client/helper/payload_helper.dart';
import 'package:go_tashkent_client/model/News_model.dart';
import 'package:go_tashkent_client/model/User_models.dart';
import 'package:go_tashkent_client/services/global_service.dart';

class NewsService {
  final GlobalService _globalService;

  NewsService({GlobalService? globalService})
      : _globalService = globalService ?? GlobalService();



  Future<NewsModel> newsUser({
    String lang = 'ru',
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        ...payload,
      });

      final response = await _globalService.dio.get(
        'mobile-client/news',
        data: formData,
        queryParameters: {'lang': lang},
      );

      final data = _globalService.handleResponse(response);

      // 🔑 JSON → model
      print("Ishladi  ${data}");
      return NewsModel.fromJson(data);

    } on DioException catch (e) {
      print("Ishlmadi xato ${e}");
      throw _globalService.handleDioError(e);
    }
  }




}
