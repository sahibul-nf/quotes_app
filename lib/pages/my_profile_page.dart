import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'My Profile',
                    style: GoogleFonts.epilogue(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Stack(
                    children: [
                      Container(
                        height: 88,
                        width: 335,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF0F1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20, top: 12),
                            child: Image(
                              height: 64,
                              width: 64,
                              image: AssetImage('assets/avatar.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kris Watson',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Ad ullamco',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 90, top: 7),
                            child: Image(
                              height: 32,
                              width: 32,
                              image: AssetImage('assets/pencil.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // button
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 44,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      const Image(
                        height: 44,
                        width: 44,
                        image: AssetImage('assets/fire.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 37, vertical: 11),
                        child: Text(
                          'Delete Account',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFFE05858),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 44,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFFEF0F1),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 19),
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage('assets/logout.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 58, vertical: 11),
                        child: Text(
                          'Sign Out',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFFE05858),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Text(
                    'Appearance'.toUpperCase(),
                    style: GoogleFonts.epilogue(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 40),
                    const Image(image: AssetImage('assets/sabit.png')),
                    const SizedBox(width: 10),
                    Text(
                      'Night mode',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 150),
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
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(right: 37),
                  child: Divider(
                    color: Color(0xFFDEE1E6),
                    indent: 37,
                    height: 0.2,
                    endIndent: 0,
                    thickness: 1,
                  ),
                ),

                // other setting
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 40),
                      child: Text(
                        'Other Settings'.toUpperCase(),
                        style: GoogleFonts.epilogue(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 40),
                        const Image(image: AssetImage('assets/ask.png')),
                        const SizedBox(width: 20),
                        Text(
                          'Help & Support',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 153),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 40),
                        const Image(image: AssetImage('assets/feedback.png')),
                        const SizedBox(width: 20),
                        Text(
                          'Feedback',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 189),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
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