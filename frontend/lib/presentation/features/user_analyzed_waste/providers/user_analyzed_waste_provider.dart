import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/analyzed_waste/analyzed_waste.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/analyzed_waste/analyzed_waste_repository.dart';

final userAnalyzedWasteProvider = StateNotifierProvider<UserScansNotifier, AsyncValue<List<AnalyzedWaste>>>(
  (ref) => UserScansNotifier(ref, ref.read(wasteRepositoryProvider)),
);

class UserScansNotifier extends StateNotifier<AsyncValue<List<AnalyzedWaste>>> {
  UserScansNotifier(this.ref, this.repository) : super(const AsyncValue.loading()) {
    getUserScans();
  }

  final Ref ref;
  final AnalyzedWasteRepository repository;

  Future<void> getUserScans() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.getUserWaste();
    });
  }
}
