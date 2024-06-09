import 'package:yapindo_test/model/news.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsFinished extends NewsState {
  List<News> news = [];
  NewsFinished({
    required this.news,
  });
}

class NewsFailed extends NewsState {
  String message;
  NewsFailed({
    required this.message,
  });
}
