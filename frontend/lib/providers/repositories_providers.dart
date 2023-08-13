import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:know_waste/repositories/analyzed_waste/analyzed_waste_repository.dart';
import 'package:know_waste/repositories/analyzed_waste/firestore_analyzed_waste_repository.dart';
import 'package:know_waste/repositories/articles/articles_repository.dart';
import 'package:know_waste/services/storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';

import '../repositories/articles/firestore_articles_repository.dart';
import '../services/collections.dart';
import '../services/database/firestore_service.dart';

final _firestoreInstance = FirestoreService(FirebaseFirestore.instance);
// final _firestoreAuthService = AuthService(FirebaseAuth.instance);
final _functions = FirebaseFunctions.instanceFor(region: 'us-central1');

final wasteRepositoryProvider = Provider<AnalyzedWasteRepository>(
  (ref) => FirestoreAnalyzedWasteRepository(_firestoreInstance, AnalyzedWasteCollection()),
);

final articlesRepositoryProvider = Provider<ArticlesRepository>(
  (ref) => FirestoreArticlesRepository(
    _firestoreInstance,
    ref.watch(firebaseStorageServiceProvider),
    ArticlesCollection(),
  ),
);
