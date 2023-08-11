import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:know_waste/repositories/waste_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../services/collections.dart';
import '../services/database/firestore_service.dart';

final _firestoreInstance = FirestoreService(FirebaseFirestore.instance);
// final _firestoreAuthService = AuthService(FirebaseAuth.instance);
final _functions = FirebaseFunctions.instanceFor(region: 'us-central1');

// final userRepository = Provider<Firebase<ChojuuUser>>(
//   (ref) => FirebaseUserRepository<ChojuuUser>(
//     _firestoreAuthService,
//     _firestoreInstance,
//     _functions,
//     UserCollection(),
//   ),
// );

final wasteRepositoryProvider = Provider<WasteRepository>(
  (ref) => FirestoreWasteRepository(
    _firestoreInstance,
    AnalyzedWasteCollection(),
  ),
);
