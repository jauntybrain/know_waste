import '../../models/article/article.dart';

abstract class ArticlesRepository {
  Future<List<Article>> getArticles();

  Future<Article?> getFeaturedArticle();

  Future<Article?> getArticle(String id);
}
