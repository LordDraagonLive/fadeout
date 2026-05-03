import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/providers.dart';
import '../../domain/entities/timer_status.dart';
import '../widgets/timer_formatter.dart';

class ActiveTimerScreen extends ConsumerWidget {
  const ActiveTimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(timerControllerProvider);
    final controller = ref.read(timerControllerProvider.notifier);
    final isPaused = session.status == TimerStatus.paused;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Running'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                TimerFormatter.compact(session.remaining),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Pause media when timer ends',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              OutlinedButton.icon(
                icon: const Icon(Icons.more_time),
                label: const Text('+10 minutes'),
                onPressed: () => controller.extend(const Duration(minutes: 10)),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                label: Text(isPaused ? 'Resume timer' : 'Pause timer'),
                onPressed: () =>
                    isPaused ? controller.resume() : controller.pause(),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.stop_circle_outlined),
                label: const Text('Stop media now'),
                onPressed: () => ref
                    .read(pauseOrStopMediaProvider)
                    .call(fadeDuration: Duration.zero),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.close),
                label: const Text('Cancel'),
                onPressed: () async {
                  await controller.cancel();
                  if (context.mounted) {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
