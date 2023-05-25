import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.secondary,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(40),
            child: Icon(
              PhosphorIcons.fill.quotes,
              size: 48,
            ),
          ),
          const SizedBox(height: 50),
          Text(
            "It's empty here",
            style: MyTypography.h2,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: MyTypography.body1.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
