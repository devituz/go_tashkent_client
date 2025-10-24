import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/services/global_service.dart';
import 'package:go_tashkent_client/services/orders_service.dart';

part 'order_store_event.dart';
part 'order_store_state.dart';
part 'order_store_bloc.freezed.dart';

class OrderStoreBloc extends Bloc<OrderStoreEvent, OrderStoreState> {
  final OrdersService _ordersService;


  OrderStoreBloc({OrdersService? ordersService})
      : _ordersService = ordersService ?? OrdersService(),
        super(const OrderStoreState.initial()) {
    on<_Order>(_onOrder);
  }


  Future<void> _onOrder(_Order event, Emitter<OrderStoreState> emit) async {
    emit(const OrderStoreState.loading());
    try {
      final result = await _ordersService.orderStore(
        fromWheresId: event.fromWheresId,
        whereTosId: event.whereTosId,
        latitude: event.latitude,
        longitude: event.longitude,
        where: event.where,
        time: event.time,
        day: event.day,
        passengersCount: event.passengersCount,
        frontSeat: event.frontSeat,
        bagaj: event.bagaj,
        toDriverComment: event.toDriverComment,
        orderType: event.orderType ?? 'mail',
        receiverName: event.receiverName,
        receiverAddress: event.receiverAddress,
        receiverPhone: event.receiverPhone,
        priceType: event.priceType ?? 'cash',
        price: event.price,
        lang: event.lang ?? 'uz',
      );

      emit(OrderStoreState.success(result));
      // print("object");
    } catch (e) {
      // print("🟧 Unexpected error: ${e.toString()}");

      if (e is ApiException) {
        // print("🟥 ApiException message: ${e.message}");
        emit(OrderStoreState.failure(e));
      } else {
        globalLogout();

      }
    }
  }
}
