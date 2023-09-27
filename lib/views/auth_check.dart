import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';
import 'menu.dart';
import 'pages/onboarding_page.dart';
import 'pages/splash_page.dart';

class AuthCheck extends ConsumerStatefulWidget {
  const AuthCheck({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthCheckState();
}

class _AuthCheckState extends ConsumerState<AuthCheck> {
  @override
  void initState() {
    super.initState();

    // check if user is logged in or not
    Future.delayed(const Duration(seconds: 1), () {
      ref.read(authProvider).checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authEvent = ref.watch(authProvider).authEvent;

    switch (authEvent) {
      case AuthEvent.loggedIn:
        return const Menu();
      case AuthEvent.loggedOut:
        return const OnboardingPage();
      default:
        return const SplashPage();
    }
  }
}
