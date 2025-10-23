import 'package:dio/dio.dart';
import 'package:go_tashkent_client/helper/payload_helper.dart';
import 'package:go_tashkent_client/model/News_model.dart';
import 'package:go_tashkent_client/model/Photos_model.dart';
import 'package:go_tashkent_client/model/User_models.dart';
import 'package:go_tashkent_client/services/global_service.dart';

class PhotosService {
  final GlobalService _globalService;

  PhotosService({GlobalService? globalService})
      : _globalService = globalService ?? GlobalService();



  Future<PhotosModel> Photos({
    required String photoType, // photo1, photo2, ...
    String lang = 'ru',
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        ...payload,
      });

      final response = await _globalService.dio.get(
        'mobile-client/$photoType',
        data: formData,
        queryParameters: {'lang': lang},
      );

      final data = _globalService.handleResponse(response);

      // 🔑 JSON → model
      print("Ishladi  ${data}");
      return PhotosModel.fromJson(data);

    } on DioException catch (e) {
      print("Ishlmadi xato ${e}");
      throw _globalService.handleDioError(e);
    }
  }




}
