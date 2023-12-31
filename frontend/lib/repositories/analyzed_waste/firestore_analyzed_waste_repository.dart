import '../../models/analyzed_waste/analyzed_waste.dart';
import '../../services/auth/auth_service.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import '../../services/storage/firebase_storage.dart';
import 'analyzed_waste_repository.dart';

class FirestoreAnalyzedWasteRepository implements AnalyzedWasteRepository {
  FirestoreAnalyzedWasteRepository(
    this.firebaseAuth,
    this.firestore,
    this.storage,
    this.wasteCollection,
  );

  final AuthService firebaseAuth;
  final FirestoreService firestore;
  final FirebaseStorageService storage;
  final FirestoreCollection<AnalyzedWaste> wasteCollection;

  @override
  Future<List<AnalyzedWaste>> getUserWaste() async {
    final analyzedWaste =
        await wasteCollection.futureAllWhereEqual('userID', firebaseAuth.currentUser!.uid, 'date', true);
    return Future.wait(
      analyzedWaste.map(
        (waste) => storage.getImageUrl(waste.imageUrl).then((url) => waste = waste.copyWith(imageUrl: url)),
      ),
    );
  }
}
