import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/views/pages/signup_page.dart';
import 'package:quotes_app/views/themes/colors.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/error_handling.dart';
import '../menu.dart';
import '../themes/typography.dart';
import '../widgets/button.dart';
import '../widgets/icon_solid_light.dart';
import '../widgets/snackbar.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> onTapSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    String? error = ErrorHandling.checkForm(email, password);
    if (error != null) {
      showSnackbar(context, error);
      return;
    }

    ref.read(authProvider).signIn(email, password).whenComplete(() {
      final authProv = ref.watch(authProvider);

      if (authProv.authState == AuthState.error) {
        showSnackbar(
          context,
          authProv.errorMessage,
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Menu(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    // Test Account
    // _emailController.text = "sahibulnuzulfirdaus13@gmail.com";
    // _passwordController.text = "sahibul";

    super.initState();
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
          "Let's Continue",
          style: MyTypography.h3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              Text("Hello!", style: MyTypography.h1),
              const SizedBox(height: 10),
              Text(
                "Welcome back",
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: MyTypography.body2.copyWith(
                          color: MyColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                onPressed:
                    authState == AuthState.loading ? null : () => onTapSignIn(),
                child: authState == AuthState.loading
                    ? const SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "Sign In",
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
                    "Don't have an account?",
                    style: MyTypography.body2.copyWith(),
                  ),
                  TextButton(
                    child: Text(
                      "Sign Up",
                      style: MyTypography.body2.copyWith(
                        color: MyColors.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
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
