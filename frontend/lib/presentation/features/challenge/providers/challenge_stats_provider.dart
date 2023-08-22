import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/challenge_stats/challenge_stats.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/challenges/challenges_repository.dart';

final challengeStatsProvider =
    StateNotifierProvider.family<ChallengeStatsNotifier, AsyncValue<List<ChallengeStats>>, String>(
  (ref, id) => ChallengeStatsNotifier(ref, id, ref.read(challengesRepositoryProvider)),
);

class ChallengeStatsNotifier extends StateNotifier<AsyncValue<List<ChallengeStats>>> {
  ChallengeStatsNotifier(this.ref, this.id, this.repository) : super(const AsyncLoading()) {
    getStats();
  }

  final Ref ref;
  final String id;
  final ChallengesRepository repository;

  int get totalRecycled => state.value?.fold<int>(0, (prev, e) => prev + e.progress) ?? 0;
  int get usersJoined => state.value?.length ?? 0;

  Future<void> getStats() async {
    state = const AsyncLoading();

    final stats = await AsyncValue.guard(() async {
      return repository.getStats(id);
    });

    state = stats;
  }
}

final userChallengeStatsProvider =
    StateNotifierProvider.family<UserChallengeStatsNotifier, AsyncValue<ChallengeStats?>, String>((ref, id) {
  return UserChallengeStatsNotifier(ref, id, ref.read(challengesRepositoryProvider));
});

class UserChallengeStatsNotifier extends StateNotifier<AsyncValue<ChallengeStats?>> {
  UserChallengeStatsNotifier(this.ref, this.challengeID, this.repository) : super(const AsyncValue.data(null)) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    ref.listen(challengeStatsProvider(challengeID), (prev, next) {
      if (next is AsyncData && next.value!.any((e) => e.userID == uid)) {
        state = AsyncData(next.value!.firstWhere((e) => e.userID == uid));
      }
    });
  }

  final Ref ref;
  final String challengeID;
  final ChallengesRepository repository;

  Future<void> joinChallenge() async {
    if (state.value != null) {
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return repository.joinChallenge(challengeID);
    });
    ref.invalidate(challengeStatsProvider(challengeID));
  }

  Future<void> quitChallenge() async {
    if (state.value == null) {
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.quitChallenge(challengeID);
      return null;
    });
    ref.invalidate(challengeStatsProvider(challengeID));
  }
}
