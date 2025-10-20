import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/model/Orders_model.dart';
import 'package:go_tashkent_client/services/global_service.dart';
import 'package:go_tashkent_client/services/orders_service.dart';

part 'orders_event.dart';
part 'orders_state.dart';
part 'orders_bloc.freezed.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersService _ordersService;

  OrdersBloc({OrdersService? ordersService})
      : _ordersService = ordersService ?? OrdersService(),
        super(const OrdersState.initial()) {
    on<_Orders>(_onAddresses);
  }

  Future<void> _onAddresses(
      _Orders event,
      Emitter<OrdersState> emit,
      ) async {
    emit(const OrdersState.loading());
    try {
      final result = await _ordersService.getOrders(
        lang: currentLang,
        active: event.active,
      );

      emit(OrdersState.success(result));
      print("✅ Orders yuklandi: ${result.toJson()}");
    } catch (e) {
      if (e is ApiException) {
        print("❌ API xato: $e");
        emit(OrdersState.failure(e));
      } else {
        print("❌ Noma’lum xato: $e");
        emit(OrdersState.failure(ApiException(e.toString())));
      }
    }
  }
}
