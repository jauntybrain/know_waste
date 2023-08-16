import 'package:know_waste/models/challenge/challenge.dart';

abstract class ChallengesRepository {
  Future<List<Challenge>> getChallenges();
}
