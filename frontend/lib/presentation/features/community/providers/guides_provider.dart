import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/guide/guide.dart';
import '../../../../providers/repositories_providers.dart';
import '../../../../repositories/guides/guides_repository.dart';

final guidesProvider = StateNotifierProvider<GuidesNotifier, AsyncValue<List<Guide>>>(
  (ref) => GuidesNotifier(ref, ref.read(guidesRepositoryProvider)),
);

class GuidesNotifier extends StateNotifier<AsyncValue<List<Guide>>> {
  GuidesNotifier(this.ref, this.repository) : super(const AsyncValue.loading()) {
    getGuides();
  }

  final Ref ref;
  final GuidesRepository repository;

  Future<void> getGuides() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return repository.getGuides();
    });
  }
}
