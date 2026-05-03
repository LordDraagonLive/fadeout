import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../monetization/domain/services/ad_visibility_policy.dart';
import '../../../monetization/presentation/widgets/ad_slot.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Default timer'),
              subtitle: Text('30 minutes'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Fade-out duration'),
              subtitle: Text('60 seconds in Free, advanced controls in Pro'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Volume restore'),
              subtitle:
                  Text('Always restore original volume after media stops'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Android setup guide'),
              subtitle: Text('Short optional battery optimization guidance'),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Upgrade to Pro'),
              subtitle:
                  const Text('Remove ads and unlock advanced fade settings'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoutes.upgrade),
            ),
            const SizedBox(height: 20),
            const Text(AppConstants.iosMediaControlDisclaimer),
            const SizedBox(height: 20),
            const AdSlot(placement: AdPlacement.settings),
          ],
        ),
      ),
    );
  }
}
