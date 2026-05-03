import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/providers.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../monetization/domain/services/ad_visibility_policy.dart';
import '../../../monetization/presentation/widgets/ad_slot.dart';
import '../../../sleep_sounds/presentation/widgets/sleep_sound_picker.dart';

class HomeTimerScreen extends ConsumerStatefulWidget {
  const HomeTimerScreen({super.key});

  @override
  ConsumerState<HomeTimerScreen> createState() => _HomeTimerScreenState();
}

class _HomeTimerScreenState extends ConsumerState<HomeTimerScreen> {
  late int _selectedMinutes = AppConstants.defaultTimerMinutes;
  late final TextEditingController _customMinutesController;

  @override
  void initState() {
    super.initState();
    _customMinutesController = TextEditingController(
      text: _selectedMinutes.toString(),
    );
  }

  @override
  void dispose() {
    _customMinutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'System media sleep timer',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Center(
              child: _TimerDial(minutes: _selectedMinutes),
            ),
            const SizedBox(height: 28),
            _PresetGrid(
              selectedMinutes: _selectedMinutes,
              onSelected: _selectMinutes,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _customMinutesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Custom minutes',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final minutes = int.tryParse(value);
                if (minutes != null && minutes > 0) {
                  setState(() => _selectedMinutes = minutes);
                }
              },
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fade out'),
              subtitle: const Text('Basic 60 second fade is included'),
              value: true,
              onChanged: null,
            ),
            const SizedBox(height: 12),
            Text(
              'Sleep sounds',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const SleepSoundPicker(),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _startTimer,
              child: const Text('Start Timer'),
            ),
            const SizedBox(height: 20),
            const AdSlot(placement: AdPlacement.home),
          ],
        ),
      ),
    );
  }

  void _selectMinutes(int minutes) {
    setState(() {
      _selectedMinutes = minutes;
      _customMinutesController.text = minutes.toString();
    });
  }

  Future<void> _startTimer() async {
    await ref
        .read(timerControllerProvider.notifier)
        .start(Duration(minutes: _selectedMinutes));

    if (mounted) {
      context.push(AppRoutes.activeTimer);
    }
  }
}

class _TimerDial extends StatelessWidget {
  const _TimerDial({required this.minutes});

  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 5,
        ),
      ),
      child: Text(
        '$minutes:00',
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}

class _PresetGrid extends StatelessWidget {
  const _PresetGrid({
    required this.selectedMinutes,
    required this.onSelected,
  });

  final int selectedMinutes;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final minutes in AppConstants.timerPresetsMinutes)
          ChoiceChip(
            label: Text('$minutes'),
            selected: selectedMinutes == minutes,
            onSelected: (_) => onSelected(minutes),
          ),
      ],
    );
  }
}
