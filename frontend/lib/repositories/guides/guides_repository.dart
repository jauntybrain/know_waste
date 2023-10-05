import '../../models/guide/guide.dart';

abstract class GuidesRepository {
  Future<List<Guide>> getGuides();

  Future<Guide?> getGuide(String id);
}
