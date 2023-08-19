import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/providers/user_provider.dart';

import '../../../../models/article/article.dart';
import '../../../../services/collections.dart';
import '../../../../services/storage/firebase_storage.dart';

final bookmarksProvider = StreamProvider.autoDispose<List<Article>>((ref) async* {
  yield* ArticlesCollection().streamAllWhereIn('uid', ref.watch(userProvider)!.bookmarks).asyncMap(
        (articles) => Future.wait(
          articles.map(
            (article) => ref
                .read(firebaseStorageServiceProvider)
                .getImageUrl(article.imageUrl)
                .then((url) => article = article.copyWith(imageUrl: url)),
          ),
        ),
      );
});
