import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/controllers/auth_controller.dart';
import 'package:quotes_app/views/auth_check.dart';

import '../../controllers/user_controller.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/snackbar.dart';

class MyProfile extends ConsumerStatefulWidget {
  const MyProfile({super.key});

  @override
  ConsumerState<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends ConsumerState<MyProfile> {
  void onTapSignOut() async {
    await ref.read(authProvider).signOut().then((_) {
      final authProv = ref.watch(authProvider);
      if (authProv.authState == AuthState.error) {
        showSnackbar(
          context,
          authProv.errorMessage,
        );

        return;
      }

      Navigator.of(context).pop(
        MaterialPageRoute(
          builder: (context) => const AuthCheck(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final authState = ref.watch(authProvider).authState;

    final username = userState!.name ?? userState.email;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 66,
        title: Text(
          "My Profile",
          style: MyTypography.h3,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MyColors.secondary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Image(
                    height: 64,
                    width: 64,
                    image: AssetImage('assets/avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userState.profession ?? '...',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: MyColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    child: const Image(
                      height: 32,
                      width: 32,
                      image: AssetImage('assets/pencil.png'),
                    ),
                  ),
                ],
              ),
            ),

            // button
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 44,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.regular.fire,
                            size: 16,
                            color: MyColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Delete Account',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFFE05858),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: InkWell(
                    onTap: authState == AuthState.loading
                        ? null
                        : () => onTapSignOut(),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 44,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFEF0F1),
                      ),
                      child: authState == AuthState.loading
                          ? const UnconstrainedBox(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  PhosphorIcons.regular.signOut,
                                  size: 16,
                                  color: MyColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Sign Out',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xFFE05858),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Appearance
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance'.toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Image(image: AssetImage('assets/sabit.png')),
                    const SizedBox(width: 16),
                    Text(
                      'Night mode',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    GFToggle(
                      onChanged: (val) {},
                      value: true,
                      type: GFToggleType.ios,
                      boxShape: BoxShape.circle,
                      enabledThumbColor: Colors.white,
                      enabledTrackColor: const Color(0xFFE05858),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Color(0xFFDEE1E6),
                  height: 0.2,
                  endIndent: 0,
                  thickness: 1,
                ),
                const SizedBox(height: 24),

                // other setting
                Text(
                  'Other Settings'.toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(image: AssetImage('assets/ask.png')),
                    const SizedBox(width: 16),
                    Text(
                      'Help & Support',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      PhosphorIcons.regular.caretRight,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(image: AssetImage('assets/feedback.png')),
                    const SizedBox(width: 16),
                    Text(
                      'Feedback',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      PhosphorIcons.regular.caretRight,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
