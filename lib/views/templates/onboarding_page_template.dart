import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../pages/signin_page.dart';
import '../pages/signup_page.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 66,
        titleSpacing: 20,
        title: Text(
          "Quot",
          style: MyTypography.h3,
        ),
        actions: [
          UnconstrainedBox(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                PhosphorIcons.regular.translate,
                size: 16,
                color: MyColors.black,
              ),
              label: Text(
                "English",
                style: MyTypography.body2,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: MyColors.black,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              "assets/img_onboarding.png",
            ),
            const SizedBox(height: 50),
            Text(
              "Welcome to Quot",
              style: MyTypography.h1.copyWith(),
            ),
            const SizedBox(height: 16),
            Text(
              "Let's get started",
              style: MyTypography.body1.copyWith(),
            ),
            const SizedBox(height: 50),
            PrimaryButton(
              child: Text(
                "Log in",
                style: MyTypography.body1.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              child: Text(
                "I'm a new, sign me up",
                style: MyTypography.body1.copyWith(
                  color: MyColors.primary,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: "By logging in or creating an account, you agree to our ",
                children: [
                  TextSpan(
                    text: "Terms of Service and Privacy Policy",
                    style: MyTypography.caption1.copyWith(
                      color: MyColors.primary,
                    ),
                  )
                ],
              ),
              style: MyTypography.caption1.copyWith(
                height: 1.5,
                color: MyColors.black,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
