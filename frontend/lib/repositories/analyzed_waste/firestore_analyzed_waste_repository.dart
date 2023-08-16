import 'package:know_waste/services/auth/auth_service.dart';

import '../../models/analyzed_waste/analyzed_waste.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import 'analyzed_waste_repository.dart';

class FirestoreAnalyzedWasteRepository implements AnalyzedWasteRepository {
  FirestoreAnalyzedWasteRepository(
    this.firebaseAuth,
    this.firestore,
    this.wasteCollection,
  );

  final AuthService firebaseAuth;
  final FirestoreService firestore;
  final FirestoreCollection<AnalyzedWaste> wasteCollection;

  @override
  Future<List<AnalyzedWaste>> getUserWaste() async {
    return wasteCollection.futureAllWhereEqual('userID', firebaseAuth.currentUser!.uid);
  }
}
