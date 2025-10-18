import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/model/Addresses_models.dart';
import 'package:go_tashkent_client/services/addresses_service.dart';
import 'package:go_tashkent_client/services/global_service.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';
part 'addresses_bloc.freezed.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final AddressesService _addressesService;

  AddressesBloc({AddressesService? addressesService})
      : _addressesService = addressesService ?? AddressesService(),
        super(const AddressesState.initial()) {
    on<_Addresses>(_onAddresses);
  }

  Future<void> _onAddresses(
      _Addresses event,
      Emitter<AddressesState> emit,
      ) async {
    emit(const AddressesState.loading());
    try {
      final result = await _addressesService.getAddresses(
        lang: currentLang,
        categoryId: event.categoryId,
      );

      emit(AddressesState.success(result));
      print("✅ Manzillar yuklandi: ${result.toJson()}");
    } catch (e) {
      if (e is ApiException) {
        print("❌ API xato: $e");
        emit(AddressesState.failure(e));
      } else {
        print("❌ Noma’lum xato: $e");
        emit(AddressesState.failure(ApiException(e.toString())));
      }
    }
  }
}
