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



  Future<Map<String, dynamic>> orderStore({
    required int fromWheresId,
    required int whereTosId,
    required double latitude,
    required double longitude,
    required String where,
    String? time,
    String? day,
    int? passengersCount,
    int? frontSeat,
    int? bagaj,
    String? toDriverComment,
    String orderType = 'mail',
    String? receiverName,
    String? receiverAddress,
    String? receiverPhone,
    String priceType = 'cash',
    int? price,
    String lang = 'uz',
  }) async {
    try {
      final payloadHelper = PayloadHelper();
      final payload = payloadHelper.createPayload();

      final formData = FormData.fromMap({
        'from_wheres_id': fromWheresId,
        'where_tos_id': whereTosId,
        'latitude': latitude,
        'longitude': longitude,
        'where': where,
        'time': time,
        'day': day,
        'passengers_count': passengersCount,
        'front_seat': frontSeat,
        'bagaj': bagaj,
        'to_driver_comment': toDriverComment,
        'order_type': orderType,
        'receiver_name': receiverName,
        'receiver_address': receiverAddress,
        'receiver_phone': receiverPhone,
        'price_type': priceType,
        'price': price,
        ...payload,
      });

      final response = await _globalService.dio.post(
        'mobile-client/order',
        data: formData,
        queryParameters: {'lang': lang},
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      final data = _globalService.handleResponse(response);

      print("✅ Buyurtma yaratildi: $data");
      return _globalService.handleResponse(response);
    } on DioException catch (e) {
      // DioException ichidagi response.data ni tekshirib, print qilamiz
      if (e.response != null) {
        print("❌ Xato (createOrder) response.data: ${e.response!.data}");
      } else {
        print("❌ Xato (createOrder) message: ${e.message}");
      }

      // Keyin throw qilamiz: Exception bilan o'rab yuboramiz
      throw Exception(e.response?.data ?? e.message);
    }
  }

}
