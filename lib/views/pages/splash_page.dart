import 'package:flutter/material.dart';
import 'package:quotes_app/views/pages/onboarding_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void startSplash(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    startSplash(context);

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 90,
        ),
      ),
    );
  }
}
