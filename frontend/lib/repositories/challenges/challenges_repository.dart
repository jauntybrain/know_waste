import 'package:know_waste/models/challenge/challenge.dart';
import 'package:know_waste/models/challenge_stats/challenge_stats.dart';

abstract class ChallengesRepository {
  Future<List<Challenge>> getChallenges();

  Future<List<ChallengeStats>> getStats(String id);
}
