import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FadeOut is a system media sleep timer.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text(
                'It is not a Spotify, YouTube, or Netflix-specific integration.',
              ),
              SizedBox(height: 16),
              Text(
                'Android users can review a short optional setup guide for more reliable timers.',
              ),
              SizedBox(height: 16),
              Text(AppConstants.iosMediaControlDisclaimer),
            ],
          ),
        ),
      ),
    );
  }
}
