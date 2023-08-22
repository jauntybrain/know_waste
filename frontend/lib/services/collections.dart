import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/analyzed_waste/analyzed_waste.dart';
import '../models/app_user/app_user.dart';
import '../models/article/article.dart';
import '../models/challenge/challenge.dart';
import '../models/guide/guide.dart';
import '../models/user_stats/user_stats.dart';
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

class UserStatsCollection extends FirestoreCollection<UserStats> {
  @override
  String get path => 'userStats';

  @override
  CollectionReference<UserStats> get withConverter => firestore.collection(path).withConverter<UserStats>(
        fromFirestore: (snapshot, _) => UserStats.fromJson(snapshot.data()!),
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
}

class ArticlesCollection extends FirestoreCollection<Article> {
  @override
  String get path => 'articles';

  @override
  CollectionReference<Article> get withConverter => firestore.collection(path).withConverter<Article>(
        fromFirestore: (snapshot, _) => Article.fromJson(snapshot.data()!..addAll({'uid': snapshot.id})),
        toFirestore: (article, _) => {},
      );
}

class GuidesCollection extends FirestoreCollection<Guide> {
  @override
  String get path => 'guides';

  @override
  CollectionReference<Guide> get withConverter => firestore.collection(path).withConverter<Guide>(
        fromFirestore: (snapshot, _) => Guide.fromJson(snapshot.data()!..addAll({'uid': snapshot.id})),
        toFirestore: (article, _) => {},
      );
}

class ChallengesCollection extends FirestoreCollection<Challenge> {
  @override
  String get path => 'challenges';

  @override
  CollectionReference<Challenge> get withConverter => firestore.collection(path).withConverter<Challenge>(
        fromFirestore: (snapshot, _) => Challenge.fromJson(snapshot.data()!..addAll({'uid': snapshot.id})),
        toFirestore: (article, _) => {},
      );
}
