import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/analyzed_waste/analyzed_waste.dart';
import '../models/app_user/app_user.dart';
import 'database/firestore_collection.dart';

class UserCollection extends FirestoreCollection<AppUser> {
  @override
  String get path => 'users';

  @override
  CollectionReference<AppUser> get withConverter => firestore.collection(path).withConverter<AppUser>(
        fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => {},
      );
}

class AnalyzedWasteCollection extends FirestoreCollection<AnalyzedWaste> {
  @override
  String get path => 'analyzedWaste';

  @override
  CollectionReference<AnalyzedWaste> get withConverter => firestore.collection(path).withConverter<AnalyzedWaste>(
        fromFirestore: (snapshot, _) => AnalyzedWaste.fromJson(snapshot.data()!..addAll({'uid': snapshot.id})),
        toFirestore: (user, _) => {},
      );

//   @override
//   AnalyzedWaste streamAllFiltered() {
//     final Stream<AnalyzedWaste?> streamController = streamAll();

//     try {
//       final snapshots = withConverter.snapshots();

//       snapshots.listen(
//         (snapshot) {
//           for (var document in snapshot.docs) {
//             streamController.add(document.data());
//           }
//         },
//         onError: (e) {
//           streamController.addError(e);
//           streamController.close();
//         },
//       );
//     } catch (e) {
//       streamController.addError(e);
//       streamController.close();
//     }

//     yield * streamController.stream;
//   }
}
