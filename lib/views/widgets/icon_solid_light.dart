import 'package:flutter/material.dart';

import '../themes/colors.dart';

class IconSolidLight extends StatelessWidget {
  const IconSolidLight({super.key, this.onTap, required this.icon});
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: MyColors.secondary,
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              color: MyColors.primaryDark,
            ),
          ),
        ),
      ),
    );
  }
}
