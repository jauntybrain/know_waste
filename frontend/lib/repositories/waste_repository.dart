import 'package:cloud_functions/cloud_functions.dart';

import '../models/analyzed_waste/analyzed_waste.dart';
import '../services/database/firestore_collection.dart';
import '../services/database/firestore_service.dart';

abstract class WasteRepository {
  Future<void> analyzeWaste(String image);
}

class FirestoreWasteRepository implements WasteRepository {
  FirestoreWasteRepository(
    this.firestore,
    this.wasteCollection,
  );

  final FirestoreService firestore;
  final FirestoreCollection<AnalyzedWaste> wasteCollection;

  @override
  Future<void> analyzeWaste(image) async {
    final createWaste = FirebaseFunctions.instanceFor(region: 'europe-west3').httpsCallable(
      'processWaste',
      options: HttpsCallableOptions(),
    );

    await createWaste.call({'imageUrl': image});

    // subscription = myCollection.snapshots().listen((QuerySnapshot snapshot) {
    //   // Handle the snapshot, which contains the added documents
    //   snapshot.docs.forEach((DocumentSnapshot document) {
    //     print('New document added: ${document.data()}');
    //   });
    // });
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
