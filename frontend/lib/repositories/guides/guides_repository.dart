import '../../models/guide/guide.dart';

abstract class GuidesRepository {
  Future<List<Guide>> getGuides();
}
