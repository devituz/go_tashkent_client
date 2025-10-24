import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/services/global_service.dart';
import 'package:go_tashkent_client/services/orders_service.dart';

part 'order_cencel_event.dart';
part 'order_cencel_state.dart';
part 'order_cencel_bloc.freezed.dart';

class OrderCencelBloc extends Bloc<OrderCencelEvent, OrderCencelState> {
  final OrdersService _ordersService;

  OrderCencelBloc({OrdersService? orderService})
      : _ordersService = orderService ?? OrdersService(),
        super(const OrderCencelState.initial()) {
    on<_Cancel>(_onCancelOrder);
  }

  Future<void> _onCancelOrder(
      _Cancel event,
      Emitter<OrderCencelState> emit,
      ) async {
    emit(const OrderCencelState.loading());

    try {
      // ✅ cancelOrder() endi String message qaytaradi
      final message = await _ordersService.cancelOrder(
        orderId: event.orderId,
        lang: currentLang,
      );

      emit(OrderCencelState.success(message));
      // print("ok ${message}");
    } catch (e) {
      if (e is ApiException) {

        emit(OrderCencelState.failure(e));
        // print("xatolik $e");
      } else {
        emit(OrderCencelState.failure(ApiException(e.toString())));
        // print("xatolik2 $e");

      }
    }
  }
}
