import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_tashkent_client/bloc/news/news_bloc.dart';
import 'package:go_tashkent_client/widgets/news_form.dart';
import 'settings.dart';
import 'package:shimmer/shimmer.dart';



class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(const NewsEvent.news()),
      child: Scaffold(
        backgroundColor: currentindex == 0
            ? const Color(0xFFF2F4F5)
            : const Color(0xFF33263C),
        appBar: AppBar(
          backgroundColor:
          currentindex == 0 ? Colors.white : const Color(0xFF43324D),
          flexibleSpace: const DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.3, color: Colors.black38),
              ),
            ),
          ),
          title: Text(
            "Новости".tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: currentindex == 0 ? Colors.black : Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            return state.when(
              initial: () => SizedBox.shrink(),
              loading: () => Center(
                child: const CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),

              success: (newsModel) {
                final newsList = newsModel.data;
                if (newsList.isEmpty) {
                  return const Center(child: Text("Yangiliklar topilmadi"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return NewsForm(
                      text: news.desc,
                      subtext: news.link,
                      widget: CachedNetworkImage(
                      imageUrl: news.image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                      createdTime: "${news.createdTime}",
                    );
                  },
                );
              },
              failure: (error) => SizedBox.shrink()
            );
          },
        ),
      ),
    );
  }
}
