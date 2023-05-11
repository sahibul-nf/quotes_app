import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTypography {
  // * Headings
  static TextStyle h1 = GoogleFonts.epilogue(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  static TextStyle h2 = GoogleFonts.epilogue(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // * Body
  static TextStyle body1 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle body2 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // * Caption
  static TextStyle caption1 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
