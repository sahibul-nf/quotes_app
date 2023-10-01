import 'package:flutter/material.dart';

class QuotWidgetPreview extends StatelessWidget {
  const QuotWidgetPreview({
    super.key,
    required this.menuWidget,
    required this.imagePreview,
  });

  final Widget menuWidget;
  final Widget imagePreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // image preview
          imagePreview,
          // share menu
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: menuWidget,
          )
        ],
      ),
    );
  }
}
