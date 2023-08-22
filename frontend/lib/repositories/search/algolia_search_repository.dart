import 'package:algoliasearch/algoliasearch_lite.dart';

import '../../models/api_error/api_error.dart';
import '../../models/article/article.dart';
import '../../services/storage/firebase_storage.dart';
import 'search_repository.dart';

class AlgoliaSearchRepository implements SearchRepository {
  AlgoliaSearchRepository(this.searchClient, this.storage);

  final SearchClient searchClient;
  final FirebaseStorageService storage;

  @override
  Future<List<Article>> searchArticles(String query) async {
    try {
      final queryHits = SearchForHits(
        indexName: 'dev_articles',
        query: query,
        hitsPerPage: 10,
      );

      final response = await searchClient.searchIndex(request: queryHits);
      final articles = response.hits.map((e) => Article.fromJson(e..addAll({'uid': e.objectID}))).toList();

      return Future.wait(
        articles.map(
          (article) => storage.getImageUrl(article.imageUrl).then((url) => article = article.copyWith(imageUrl: url)),
        ),
      );
    } catch (e) {
      throw ApiError(message: 'Search error');
    }
  }
}
