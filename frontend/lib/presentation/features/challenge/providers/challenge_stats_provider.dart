import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/models/challenge_stats/challenge_stats.dart';
import 'package:know_waste/repositories/challenges/challenges_repository.dart';

import '../../../../providers/repositories_providers.dart';

final challengeStatsProvider =
    StateNotifierProvider.family.autoDispose<ChallengeStatsNotifier, AsyncValue<List<ChallengeStats>>, String>(
  (ref, id) => ChallengeStatsNotifier(ref, id, ref.read(challengesRepositoryProvider)),
);

class ChallengeStatsNotifier extends StateNotifier<AsyncValue<List<ChallengeStats>>> {
  ChallengeStatsNotifier(this.ref, this.id, this.repository) : super(const AsyncLoading()) {
    getStats();
  }

  final Ref ref;
  final String id;
  final ChallengesRepository repository;

  int get totalRecycled {
    final stateValue = state.value;

    if (stateValue == null) {
      return 0;
    }

    return stateValue.fold<int>(0, (prev, e) => prev + e.progress);
  }

  int get usersJoined => state.value?.length ?? 0;

  Future<void> getStats() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.getStats(id);
    });
  }
}

// final userChallengeProvider =
//     StateNotifierProvider.family<ChallengeStatsNotifier, AsyncValue<ChallengeStats>, String>(
//   (ref, id) => ChallengeStatsNotifier(ref, id, ref.read(challengesRepositoryProvider)),
// );

// class UserChallengeStatsProvider extends StateNotifier<AsyncValue<List<ChallengeStats>>> {
//   ChallengeStatsNotifier(this.ref, this.id, this.repository) : super(const AsyncLoading()) {
//     getStats();
//   }

//   final Ref ref;
//   final String id;
//   final ChallengesRepository repository;

//   int get totalRecycled {
//     final stateValue = state.value;

//     if (stateValue == null) {
//       return 0;
//     }

//     return stateValue.fold<int>(0, (prev, e) => prev + e.progress);
//   }

//   int get usersJoined => state.value?.length ?? 0;

//   Future<void> getStats() async {
//     state = const AsyncValue.loading();

//     state = await AsyncValue.guard(() async {
//       return repository.getStats(id);
//     });
//   }
// }
