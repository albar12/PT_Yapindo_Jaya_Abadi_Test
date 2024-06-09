import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:yapindo_test/model/news.dart';
import 'package:yapindo_test/news/news_bloc/news_event.dart';
import 'package:yapindo_test/news/news_bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsStart>(newsStart);
  }

  Future<void> newsStart(
    NewsStart event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://newsapi.org/v2/top-headlines",
        queryParameters: {
          "country": "id",
          "category": "business",
          "apiKey": "ea96c78d668a4ff3823629ac053c59ca",
        },
      );
      print(response.statusCode);
      // print(jsonEncode(response.data['articles'][0]['source']));
      print(response.data['articles'][0]['source']);
      List<News> dataNews = [];
      for (int i = 0; i < jsonEncode(response.data['articles']).length; i++) {
        print("object");
        if (i < 20) {
          News berita = News(
            source: response.data['articles'][i]['source'],
            author: jsonEncode(
              response.data['articles'][i]['author'],
            ),
            title: jsonEncode(
              response.data['articles'][i]['title'],
            ),
            description: jsonEncode(
              response.data['articles'][i]['description'],
            ),
            urlToImage: jsonEncode(
              response.data['articles'][i]['urlToImage'],
            ),
            publishedAt: jsonEncode(
              response.data['articles'][i]['publishedAt'],
            ),
            content: jsonEncode(
              response.data['articles'][i]['content'],
            ),
          );
          dataNews.add(berita);
        }
      }

      print("test");
      print(dataNews);

      emit(NewsFinished(news: dataNews));
    } catch (e) {
      print(e.toString());
      emit(NewsFailed(message: "Error ${e}"));
    }
  }
}
