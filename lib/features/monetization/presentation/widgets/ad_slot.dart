import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';
import '../../domain/services/ad_visibility_policy.dart';

class AdSlot extends ConsumerWidget {
  const AdSlot({
    required this.placement,
    super.key,
  });

  final AdPlacement placement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShow = ref.watch(adVisibilityProvider(placement));

    if (!shouldShow) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Text(
        'Ad placement',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
