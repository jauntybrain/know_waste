import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:know_waste/repositories/analyzed_waste/analyzed_waste_repository.dart';
import 'package:know_waste/repositories/analyzed_waste/firestore_analyzed_waste_repository.dart';
import 'package:know_waste/repositories/articles/articles_repository.dart';
import 'package:know_waste/repositories/challenges/challenges_repository.dart';
import 'package:know_waste/repositories/guides/guides_repository.dart';
import 'package:know_waste/repositories/search/algolia_search_repository.dart';
import 'package:know_waste/repositories/search/search_repository.dart';
import 'package:know_waste/repositories/user/firestore_user_repository.dart';
import 'package:know_waste/services/storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';

import '../repositories/articles/firestore_articles_repository.dart';
import '../repositories/challenges/firestore_challenges_repository.dart';
import '../repositories/guides/firestore_guides_repository.dart';
import '../repositories/user/user_repository.dart';
import '../services/auth/auth_service.dart';
import '../services/collections.dart';
import '../services/database/firestore_service.dart';

// final _functions = FirebaseFunctions.instanceFor(region: 'us-central1');
final _firestoreInstance = FirestoreService(FirebaseFirestore.instance);
final _firestoreAuthService = AuthService(FirebaseAuth.instance);
final _algoliaClient = SearchClient(
  appId: 'NXV291HOZJ',
  apiKey: 'a8268e987fac6baed666d0bad6ec81cb',
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => FirestoreUserRepository(
    _firestoreAuthService,
    _firestoreInstance,
    UserCollection(),
    UserStatsCollection(),
  ),
);

final wasteRepositoryProvider = Provider<AnalyzedWasteRepository>(
  (ref) => FirestoreAnalyzedWasteRepository(
    _firestoreAuthService,
    _firestoreInstance,
    ref.watch(firebaseStorageServiceProvider),
    AnalyzedWasteCollection(),
  ),
);

final articlesRepositoryProvider = Provider<ArticlesRepository>(
  (ref) => FirestoreArticlesRepository(
    _firestoreInstance,
    ref.watch(firebaseStorageServiceProvider),
    ArticlesCollection(),
  ),
);

final guidesRepositoryProvider = Provider<GuidesRepository>(
  (ref) => FirestoreGuidesRepository(
    _firestoreInstance,
    ref.watch(firebaseStorageServiceProvider),
    GuidesCollection(),
  ),
);

final challengesRepositoryProvider = Provider<ChallengesRepository>(
  (ref) => FirestoreChallengesRepository(
    _firestoreInstance,
    ref.watch(firebaseStorageServiceProvider),
    ChallengesCollection(),
  ),
);

final searchRepositoryProvider = Provider<SearchRepository>(
  (ref) => AlgoliaSearchRepository(
    _algoliaClient,
    ref.watch(firebaseStorageServiceProvider),
  ),
);
