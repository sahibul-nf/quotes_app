import 'package:flutter/material.dart';
import 'package:quotes_app/views/themes/colors.dart';

class MyTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    colorSchemeSeed: MaterialColor(
      MyColors.primary.value,
      <int, Color>{
        50: MyColors.primary.withOpacity(0.1),
        100: MyColors.primary.withOpacity(0.2),
        200: MyColors.primary.withOpacity(0.3),
        300: MyColors.primary.withOpacity(0.4),
        400: MyColors.primary.withOpacity(0.5),
        500: MyColors.primary.withOpacity(0.6),
        600: MyColors.primary.withOpacity(0.7),
        700: MyColors.primary.withOpacity(0.8),
        800: MyColors.primary.withOpacity(0.9),
        900: MyColors.primary.withOpacity(1.0),
      },
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
  );

  // Dark Theme
  // TODO: Add dark theme colors
  static final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorSchemeSeed: MaterialColor(
      MyColors.secondary.value,
      <int, Color>{
        50: MyColors.secondary.withOpacity(0.1),
        100: MyColors.secondary.withOpacity(0.2),
        200: MyColors.secondary.withOpacity(0.3),
        300: MyColors.secondary.withOpacity(0.4),
        400: MyColors.secondary.withOpacity(0.5),
        500: MyColors.secondary.withOpacity(0.6),
        600: MyColors.secondary.withOpacity(0.7),
        700: MyColors.secondary.withOpacity(0.8),
        800: MyColors.secondary.withOpacity(0.9),
        900: MyColors.secondary.withOpacity(1.0),
      },
    ),
    scaffoldBackgroundColor: MyColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.black,
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColors.primary,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: MyColors.black,
      selectedItemColor: MyColors.primary,
      unselectedItemColor: MyColors.secondary,
    ),
  );
}
