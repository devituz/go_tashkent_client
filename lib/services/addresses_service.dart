import 'package:dio/dio.dart';
import 'package:go_tashkent_client/helper/payload_helper.dart';
import 'package:go_tashkent_client/model/Addresses_models.dart';
import 'package:go_tashkent_client/model/News_model.dart';
import 'package:go_tashkent_client/model/User_models.dart';
import 'package:go_tashkent_client/services/global_service.dart';

class AddressesService {
  final GlobalService _globalService;

  AddressesService({GlobalService? globalService})
      : _globalService = globalService ?? GlobalService();



  Future<AddressModel> getAddresses({
    String lang = 'ru',
    int? categoryId,
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final response = await _globalService.dio.get(
        'mobile-client/addresses',
        queryParameters: {
          'lang': lang,
          if (categoryId != null) 'category_id': categoryId,
          ...payload,
        },
      );

      final data = _globalService.handleResponse(response);

      print("✅ Ishladi: $data");
      return AddressModel.fromJson(data);

    } on DioException catch (e) {
      print("❌ Xato: $e");
      throw _globalService.handleDioError(e);
    }
  }




}
