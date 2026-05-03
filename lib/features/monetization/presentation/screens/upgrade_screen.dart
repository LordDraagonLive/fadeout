import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FadeOut Pro')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Lifetime Pro',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              const Text('Remove ads and unlock advanced fade settings.'),
              const SizedBox(height: 24),
              Text(
                '\$${AppConstants.proLifetimePriceUsd}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Spacer(),
              FilledButton(
                onPressed: null,
                child: const Text('Purchase provider not selected yet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
