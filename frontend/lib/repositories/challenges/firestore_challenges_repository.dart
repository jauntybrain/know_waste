import 'package:know_waste/models/challenge_stats/challenge_stats.dart';
import 'package:know_waste/services/storage/firebase_storage.dart';

import '../../models/api_error/api_error.dart';
import '../../models/challenge/challenge.dart';
import '../../services/database/firestore_collection.dart';
import '../../services/database/firestore_service.dart';
import 'challenges_repository.dart';

class FirestoreChallengesRepository implements ChallengesRepository {
  FirestoreChallengesRepository(
    this.firestore,
    this.storage,
    this.challengesCollection,
  );

  final FirestoreService firestore;
  final FirebaseStorageService storage;
  final FirestoreCollection<Challenge> challengesCollection;

  @override
  Future<List<Challenge>> getChallenges() async {
    try {
      final challenges = await challengesCollection.futureAll();

      return Future.wait(
        challenges.map(
          (challenge) async {
            final imageUrl = await storage.getImageUrl(challenge.imageUrl);
            final iconUrl = await storage.getImageUrl(challenge.iconUrl);
            return challenge.copyWith(imageUrl: imageUrl, iconUrl: iconUrl);
          },
        ),
      );
    } catch (e) {
      throw ApiError(message: 'Error fetching challenges');
    }
  }

  @override
  Future<List<ChallengeStats>> getStats(String id) async {
    try {
      final snapshot = await firestore.db.collection('${challengesCollection.path}/$id/stats').get();
      return snapshot.docs.map((doc) => ChallengeStats.fromJson(doc.data())).toList();
    } catch (e) {
      throw ApiError(message: 'Error fetching stats');
    }
  }
}
