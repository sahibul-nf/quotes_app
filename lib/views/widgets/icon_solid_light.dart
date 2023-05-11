import 'package:flutter/material.dart';
import 'package:quotes_app/views/themes/colors.dart';

class IconSolidLight extends StatelessWidget {
  const IconSolidLight({super.key, required this.icon, this.onPressed});
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {},
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      focusColor: MyColors.secondary,
      hoverColor: MyColors.secondary,
      backgroundColor: MyColors.secondary,
      child: Icon(
        icon,
        color: MyColors.primaryDark,
      ),
    );
  }
}
