import '../../models/analyzed_waste/analyzed_waste.dart';

abstract class AnalyzedWasteRepository {
  Future<List<AnalyzedWaste>> getUserWaste();
}
