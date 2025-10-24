import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/model/News_model.dart';
import 'package:go_tashkent_client/services/news_service.dart';

import '../../services/global_service.dart';

part 'news_event.dart';
part 'news_state.dart';
part 'news_bloc.freezed.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService;

  NewsBloc({NewsService? newsService})
      : _newsService = newsService ?? NewsService(),
        super(const NewsState.initial()) {
    on<_News>(_onProfile);
  }

  Future<void> _onProfile(_News event, Emitter<NewsState> emit) async {
    emit(const NewsState.loading());
    try {

      final result = await _newsService.newsUser(
          lang: currentLang
      );
      emit(NewsState.success(result));
      // print(result.toJson());
    } catch (e) {
      if (e is ApiException) {
        // print(e);
        emit(NewsState.failure(e));
      } else {
        // print(e);

        emit(NewsState.failure(ApiException(e.toString())));
      }
    }
  }

  
}
