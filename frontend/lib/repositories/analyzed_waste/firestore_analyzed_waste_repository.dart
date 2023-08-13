import '../../models/analyzed_waste/analyzed_waste.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import 'analyzed_waste_repository.dart';

class FirestoreAnalyzedWasteRepository implements AnalyzedWasteRepository {
  FirestoreAnalyzedWasteRepository(this.firestore, this.wasteCollection);

  final FirestoreService firestore;
  final FirestoreCollection<AnalyzedWaste> wasteCollection;

  @override
  Future<void> analyzeWaste(image) async {
    // final createWaste = FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable(
    //   'processWaste',
    //   options: HttpsCallableOptions(),
    // );

    // await createWaste.call({'imageUrl': image});
  }
  // @override
  // Future<AnalyzedWaste> getUserWaste(
  //   String uid,
  //   int limit,
  //   UserType userType,
  // ) async {
  //   try {
  //     final response = FirestorePagination<UserWaste>(
  //       await appointmentDataSource.getUserWastes(uid, userType),
  //       limit,
  //       true,
  //     );
  //     return response;
  //   } catch (e) {
  //     Logger.logException(e);
  //     rethrow;
  //   }
  // }
}
