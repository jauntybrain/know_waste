import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/article/article.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/articles/articles_repository.dart';

final featuredArticleProvider = StateNotifierProvider<FeaturedArticleNotifier, AsyncValue<Article?>>(
  (ref) => FeaturedArticleNotifier(ref, ref.read(articlesRepositoryProvider)),
);

class FeaturedArticleNotifier extends StateNotifier<AsyncValue<Article?>> {
  FeaturedArticleNotifier(this.ref, this.repository) : super(const AsyncValue.loading()) {
    getFeaturedArticle();
  }

  final Ref ref;
  final ArticlesRepository repository;

  Future<void> getFeaturedArticle() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.getFeaturedArticle();
    });
  }
}
