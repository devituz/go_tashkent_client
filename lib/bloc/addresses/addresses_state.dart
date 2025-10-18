part of 'addresses_bloc.dart';

@freezed
class AddressesState with _$AddressesState {
  const factory AddressesState.initial() = _Initial;
  const factory AddressesState.loading() = _Loading;
  const factory AddressesState.success(AddressModel profile) = _Success;
  const factory AddressesState.failure(ApiException error) = _Failure;
}
