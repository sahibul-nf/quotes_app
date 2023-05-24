import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/views/themes/colors.dart';

class MyTypography {
  // * Headings
  static TextStyle h1 = GoogleFonts.epilogue(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: MyColors.black,
  );
  static TextStyle h2 = GoogleFonts.epilogue(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: MyColors.black,
  );
  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: MyColors.black,
  );

  // * Body
  static TextStyle body1 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyColors.black,
  );
  static TextStyle body2 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: MyColors.black,
  );

  // * Caption
  static TextStyle caption1 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
