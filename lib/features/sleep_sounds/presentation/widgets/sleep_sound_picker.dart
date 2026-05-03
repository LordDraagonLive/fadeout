import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/providers.dart';

class SleepSoundPicker extends ConsumerWidget {
  const SleepSoundPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sounds = ref.watch(listSleepSoundsProvider)();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final sound in sounds)
          ChoiceChip(
            label: Text(sound.name),
            selected: false,
            onSelected: (_) {},
          ),
      ],
    );
  }
}
