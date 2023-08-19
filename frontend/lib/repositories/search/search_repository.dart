import '../../models/article/article.dart';

abstract class SearchRepository {
  Future<List<Article>> searchArticles(String query);
}
