import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_waste/presentation/router/router_context_extension.dart';

import '../../../../../models/api_error/api_error.dart';
import '../../../../theme/src/app_text_styles.dart';
import '../../providers/challenges_provider.dart';
import '../../widgets/challenge/challenge_skeleton.dart';
import '../../widgets/challenge/challenge_widget.dart';

class CommunityChallengesSection extends ConsumerWidget {
  const CommunityChallengesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesState = ref.watch(challengesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Try a Challenge',
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
            height: 250,
            key: ValueKey(challengesState),
            child: challengesState.when(
              data: (challenges) => ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: challenges.length,
                itemBuilder: (context, index) => ChallengeWidget(
                  challenge: challenges[index],
                  onTap: context.pushChallenge,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
              ),
              error: (e, tr) => Center(
                child: e is ApiError ? Text((e).message) : const Text('Error occurred'),
              ),
              loading: () => ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 4,
                itemBuilder: (context, index) => const ChallengeSkeleton(),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
