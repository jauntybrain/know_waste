import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';

import '../../../../../models/api_error/api_error.dart';
import '../../../../theme/theme.dart';
import '../../providers/guides_provider.dart';
import '../../widgets/guide/guide_widget.dart';
import '../../widgets/guide/guide_widget_skeleton.dart';

class CommunityGuidesSection extends ConsumerWidget {
  const CommunityGuidesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guidesState = ref.watch(guidesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Recycling 101',
            style: AppTextStyles.blackBlack22.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            key: ValueKey(guidesState),
            height: 190,
            width: MediaQuery.of(context).size.width,
            child: guidesState.when(
              data: (guides) => MasonryGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                scrollDirection: Axis.horizontal,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                crossAxisCount: 2,
                itemCount: guides.length,
                itemBuilder: (context, index) => GuideWidget(
                  guide: guides[index],
                  onTap: context.pushGuide,
                ),
              ),
              error: (e, tr) => Center(
                child: e is ApiError ? Text((e).message) : const Text('Error occurred'),
              ),
              loading: () => MasonryGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                scrollDirection: Axis.horizontal,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                crossAxisCount: 2,
                itemCount: 4,
                itemBuilder: (context, index) => const GuideWidgetSkeleton(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
