import 'package:know_waste/services/storage/firebase_storage.dart';

import '../../models/api_error/api_error.dart';
import '../../models/article/article.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import 'articles_repository.dart';

class FirestoreArticlesRepository implements ArticlesRepository {
  FirestoreArticlesRepository(
    this.firestore,
    this.storage,
    this.articlesCollection,
  );

  final FirestoreService firestore;
  final FirebaseStorageService storage;
  final FirestoreCollection<Article> articlesCollection;

  @override
  Future<List<Article>> getArticles() async {
    try {
      final articles = await articlesCollection.futureAll('date', true);

      return Future.wait(
        articles.map(
          (article) => storage.getImageUrl(article.imageUrl).then((url) => article = article.copyWith(imageUrl: url)),
        ),
      );
    } catch (e) {
      throw ApiError(message: 'Error fetching articles');
    }
  }
  

  @override
  Future<Article?> getFeaturedArticle() async {
    try {
      final article = await articlesCollection.futureSingleWhereEqual('featured', true);
      if (article == null) {
        return article;
      }

      final imageUrl = await storage.getImageUrl(article.imageUrl);
      return article.copyWith(imageUrl: imageUrl);
    } catch (err) {
      throw ApiError(message: 'Error fetching featured article');
    }
  }
}
