import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/views/themes/colors.dart';

class MyLeading extends StatelessWidget {
  const MyLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          color: MyColors.secondary,
          padding: const EdgeInsets.all(8),
          child: Icon(
            PhosphorIcons.regular.caretLeft,
            color: MyColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
