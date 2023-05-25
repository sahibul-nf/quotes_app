import 'package:flutter/material.dart';

import '../menu.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void startSplash(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Menu(),
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
