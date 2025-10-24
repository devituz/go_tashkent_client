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
    on<_CancelOrder>(_onCancelOrder);
  }

  Future<void> _onCancelOrder(
      _CancelOrder event,
      Emitter<OrderCencelState> emit,
      ) async {
    emit(const OrderCencelState.loading());

    try {
      await _ordersService.cancelOrder(
        orderId: event.orderId,
        lang: currentLang,
      );

      emit(const OrderCencelState.success());
    } catch (e) {
      if (e is ApiException) {
        emit(OrderCencelState.failure(e));
      } else {
        emit(OrderCencelState.failure(ApiException(e.toString())));
      }
    }
  }
}
