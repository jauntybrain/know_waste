import '../../models/challenge/challenge.dart';
import '../../models/challenge_stats/challenge_stats.dart';

abstract class ChallengesRepository {
  Future<List<Challenge>> getChallenges();

  Future<Challenge?> getChallenge(String id);

  Future<List<ChallengeStats>> getStats(String id);

  Future<ChallengeStats> joinChallenge(String id);

  Future<void> quitChallenge(String id);
}
