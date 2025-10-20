import 'package:dio/dio.dart';
import 'package:go_tashkent_client/helper/payload_helper.dart';
import 'package:go_tashkent_client/model/Orders_model.dart';
import 'package:go_tashkent_client/services/global_service.dart';

class OrdersService {
  final GlobalService _globalService;

  OrdersService({GlobalService? globalService})
      : _globalService = globalService ?? GlobalService();

  Future<OrdersModel> getOrders({
    String lang = 'ru',
    bool active = false,
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final response = await _globalService.dio.get(
        'mobile-client/order',
        queryParameters: {
          'lang': lang,
          'active': active,
          ...payload,
        },
      );

      final data = _globalService.handleResponse(response);

      print("✅ Buyurtmalar olindi: $data");
      return OrdersModel.fromJson(data);

    } on DioException catch (e) {
      print("❌ Xato (getOrders): $e");
      throw _globalService.handleDioError(e);
    }
  }
}
