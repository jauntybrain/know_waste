import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/article/article.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/search/search_repository.dart';

final searchProvider = StateNotifierProvider.autoDispose<SearchNotifier, AsyncValue<List<Article>?>>(
  (ref) => SearchNotifier(ref, ref.watch(searchRepositoryProvider)),
);

class SearchNotifier extends StateNotifier<AsyncValue<List<Article>?>> {
  SearchNotifier(this.ref, this.repository) : super(const AsyncValue.data(null));

  final Ref ref;
  final SearchRepository repository;

  Future<void> searchArticles(String query) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.searchArticles(query);
    });
  }
}
