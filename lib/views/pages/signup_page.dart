import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/controllers/auth_controller.dart';
import 'package:quotes_app/utils/error_handling.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/button.dart';
import '../widgets/icon_solid_light.dart';
import '../widgets/snackbar.dart';
import 'signin_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> onTapSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    String? error = ErrorHandling.checkForm(email, password);
    if (error != null) {
      showSnackbar(context, error);
      return;
    }

    ref.read(authProvider).signUp(email, password).whenComplete(() {
      final authProv = ref.watch(authProvider);

      if (authProv.authState == AuthState.error) {
        showSnackbar(
          context,
          authProv.errorMessage,
        );
      } else {
        showSnackbar(
          context,
          'Account created successfully! Please login.',
          isError: false,
        );

        // back to onboarding
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider).authState;

    return Scaffold(
      backgroundColor: MyColors.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.secondary,
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
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
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
                    controller: _emailController,
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
                    controller: _passwordController,
                    obscureText: true,
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
                onPressed:
                    authState == AuthState.loading ? null : () => onTapSignUp(),
                child: authState == AuthState.loading
                    ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Sign Up",
                        style: MyTypography.body1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
