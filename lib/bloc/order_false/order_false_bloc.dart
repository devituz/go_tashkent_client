import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/model/Orders_model.dart';
import 'package:go_tashkent_client/services/global_service.dart';
import 'package:go_tashkent_client/services/orders_service.dart';

part 'order_false_event.dart';
part 'order_false_state.dart';
part 'order_false_bloc.freezed.dart';

class OrderFalseBloc extends Bloc<OrderFalseEvent, OrderFalseState> {
  final OrdersService _ordersService;

  OrderFalseBloc({OrdersService? ordersService})
      : _ordersService = ordersService ?? OrdersService(),
        super(const OrderFalseState.initial()) {
    on<_Orders>(_onAddresses);
  }

  Future<void> _onAddresses(
      _Orders event,
      Emitter<OrderFalseState> emit,
      ) async {
    emit(const OrderFalseState.loading());
    try {
      final result = await _ordersService.getOrders(
        lang: currentLang,
        active: event.active,
      );

      emit(OrderFalseState.success(result));
      // print("✅ Orders yuklandi: ${result.toJson()}");
    } catch (e) {
      if (e is ApiException) {
        // print("❌ API xato: $e");
        emit(OrderFalseState.failure(e));
      } else {
        // print("❌ Noma’lum xato: $e");
        emit(OrderFalseState.failure(ApiException(e.toString())));
      }
    }
  }
}
