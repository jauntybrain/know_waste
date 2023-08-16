import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/models/challenge/challenge.dart';
import 'package:know_waste/repositories/challenges/challenges_repository.dart';

import '../../../../providers/repositories_providers.dart';

final challengeProvider = StateNotifierProvider.family<ChallengeNotifier, Challenge, Challenge>(
  (ref, challenge) => ChallengeNotifier(ref, challenge, ref.read(challengesRepositoryProvider)),
);

class ChallengeNotifier extends StateNotifier<Challenge> {
  ChallengeNotifier(this.ref, this.challenge, this.repository) : super(challenge) {
    getStats();
  }

  final Ref ref;
  final Challenge challenge;
  final ChallengesRepository repository;

  Future<void> getStats() async {
    // TODO
  }
}
