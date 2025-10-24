part of 'addresses_bloc.dart';

@freezed
class AddressesEvent with _$AddressesEvent {
  const factory AddressesEvent.addresses({
    int? categoryId,
    String? search,
  }) = _Addresses;

}
