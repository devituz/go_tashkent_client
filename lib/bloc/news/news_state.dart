part of 'news_bloc.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.initial() = _Initial;
  const factory NewsState.loading() = _Loading;
  const factory NewsState.success(NewsModel profile) = _Success;
  const factory NewsState.failure(ApiException error) = _Failure;
}
