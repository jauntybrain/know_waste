import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/article/article.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/articles/articles_repository.dart';

final articlesProvider = StateNotifierProvider<ArticlesNotifier, AsyncValue<List<Article>>>(
  (ref) => ArticlesNotifier(ref, ref.read(articlesRepositoryProvider)),
);

class ArticlesNotifier extends StateNotifier<AsyncValue<List<Article>>> {
  ArticlesNotifier(this.ref, this.repository) : super(const AsyncValue.loading()) {
    getAllArticles();
  }

  final Ref ref;
  final ArticlesRepository repository;

  Future<void> getAllArticles() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.getArticles();
    });
  }
}
