import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';

import '../../../../models/api_error/api_error.dart';
import '../../../shared/app_icon_button.dart';
import '../../../theme/theme.dart';
import '../providers/user_analyzed_waste_provider.dart';
import '../widgets/analyzed_waste_skeleton.dart';
import '../widgets/analyzed_waste_widget.dart';

class UserAnalyzedWastePage extends ConsumerWidget {
  const UserAnalyzedWastePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userWasteState = ref.watch(userAnalyzedWasteProvider);
    final isEmpty = userWasteState.value?.isEmpty ?? false;

    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Page content
            Positioned.fill(
              child: RefreshIndicator.adaptive(
                edgeOffset: MediaQuery.of(context).viewPadding.top + 60,
                onRefresh: () async {
                  HapticFeedback.lightImpact();
                  ref.invalidate(userAnalyzedWasteProvider);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: isEmpty ? MediaQuery.of(context).size.height : null,
                    ),
                    child: Column(
                      mainAxisAlignment: isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isEmpty) SizedBox(height: MediaQuery.of(context).viewPadding.top + 80),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey(userWasteState),
                            child: userWasteState.when(
                              data: (waste) => waste.isNotEmpty
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 280,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                      ),
                                      itemCount: waste.length,
                                      itemBuilder: (context, index) => AnalyzedWasteWidget(
                                        analyzedWaste: waste[index],
                                        onTap: context.pushAnalyzedWaste,
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.archive_rounded,
                                              color: AppColors.secondary,
                                              size: 70,
                                            ),
                                            const SizedBox(height: 10),
                                            Text('Nothing here yet', style: AppTextStyles.blackExtraBold16),
                                          ],
                                        ),
                                      ),
                                    ),
                              error: (e, tr) => Center(
                                child: e is ApiError ? Text((e).message) : const Text('Error occurred'),
                              ),
                              loading: () => GridView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 280,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                                itemCount: 4,
                                itemBuilder: (context, index) => const AnalyzedWasteSkeleton(),
                              ),
                            ),
                          ),
                        ),
                        if (!isEmpty) SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 120),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Top Navigation
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [AppShadows.small],
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 12,
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      onTap: () => GoRouter.of(context).pop(),
                      size: 45,
                      iconSize: 22,
                      fillColor: AppColors.primary.withOpacity(0.1),
                      icon: Icons.chevron_left_rounded,
                    ),
                    Text(
                      'Scans',
                      style: AppTextStyles.blackBlack22.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 45),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
