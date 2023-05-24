import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kris Watson',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ad ullamco',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: MyColors.black,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
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
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
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
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFEF0F1),
                    ),
                    child: Row(
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
