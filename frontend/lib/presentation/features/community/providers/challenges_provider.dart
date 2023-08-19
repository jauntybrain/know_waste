import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/models/challenge/challenge.dart';

import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/challenges/challenges_repository.dart';

final challengesProvider = StateNotifierProvider<ChallengesNotifier, AsyncValue<List<Challenge>>>(
  (ref) => ChallengesNotifier(ref, ref.read(challengesRepositoryProvider)),
);

class ChallengesNotifier extends StateNotifier<AsyncValue<List<Challenge>>> {
  ChallengesNotifier(this.ref, this.repository) : super(const AsyncValue.loading()) {
    getChallenges();
  }

  final Ref ref;
  final ChallengesRepository repository;

  Future<void> getChallenges() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.getChallenges();
    });
  }
}
