

import '../../models/api_error/api_error.dart';
import '../../models/guide/guide.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import '../../services/storage/firebase_storage.dart';
import 'guides_repository.dart';

class FirestoreGuidesRepository implements GuidesRepository {
  FirestoreGuidesRepository(
    this.firestore,
    this.storage,
    this.guidesCollection,
  );

  final FirestoreService firestore;
  final FirebaseStorageService storage;
  final FirestoreCollection<Guide> guidesCollection;

  @override
  Future<List<Guide>> getGuides() async {
    try {
      final guides = await guidesCollection.futureAll();

      return Future.wait(
        guides.map(
          (article) async {
            final imageUrl = await storage.getImageUrl(article.imageUrl);
            final iconUrl = await storage.getImageUrl(article.iconUrl);
            return article.copyWith(imageUrl: imageUrl, iconUrl: iconUrl);
          },
        ),
      );
    } catch (e) {
      throw ApiError(message: 'Error fetching guides');
    }
  }
}
