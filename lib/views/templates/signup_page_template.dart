import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../pages/signin_page.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/button.dart';
import '../widgets/icon_solid_light.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondary,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 76,
        leading: IconSolidLight(
          icon: PhosphorIcons.regular.caretLeft,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Get Started",
          style: MyTypography.h3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 70,
            bottom: 40,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome!", style: MyTypography.h1),
              const SizedBox(height: 10),
              Text(
                "Create an account",
                style: MyTypography.caption1.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              // TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: MyTypography.body1.copyWith(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Password",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      hintStyle: MyTypography.body1.copyWith(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        activeColor: MyColors.primary,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "I agree to the ",
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: MyTypography.body2.copyWith(
                                color: MyColors.primary,
                              ),
                            )
                          ],
                        ),
                        style: MyTypography.body2.copyWith(),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                child: Text(
                  "Sign Up",
                  style: MyTypography.body1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 30),
              // Social Media Buttons
              Column(
                children: [
                  Text(
                    "Or continue with".toUpperCase(),
                    style: MyTypography.caption1.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img_google.png", width: 32),
                      const SizedBox(width: 40),
                      Image.asset("assets/img_facebook.png", width: 32),
                      const SizedBox(width: 40),
                      Image.asset("assets/img_apple.png", width: 32),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: MyTypography.body2.copyWith(),
                  ),
                  TextButton(
                    child: Text(
                      "Sign In",
                      style: MyTypography.body2.copyWith(
                        color: MyColors.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
