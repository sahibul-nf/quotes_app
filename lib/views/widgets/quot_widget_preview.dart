import 'dart:typed_data';

import 'package:flutter/material.dart';

class QuotWidgetPreview extends StatelessWidget {
  const QuotWidgetPreview(
      {super.key, required this.memoryImage, required this.menuWidget});
  final Uint8List memoryImage;
  final Widget menuWidget;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: MemoryImage(memoryImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          // share menu
          const SizedBox(height: 40),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: menuWidget,
          )
        ],
      ),
    );
  }
}
