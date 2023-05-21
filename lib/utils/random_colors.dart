import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quotes_app/views/themes/colors.dart';

Color getRandomColor() {
  final random = Random();

  final colorsCode = MyColors.quoteCardColors;

  return Color(colorsCode[random.nextInt(11)]);
}
