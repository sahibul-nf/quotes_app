import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';

class QuotesCard extends StatelessWidget {
  const QuotesCard({
    super.key,
    required this.content,
    required this.author,
    this.authorAvatar,
    this.authorJob,
    this.textAlign,
    this.color,
  });
  final Color? color;
  final String content;
  final String author;
  final String? authorAvatar;
  final String? authorJob;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        color: color ?? MyColors.primary,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 168,
            top: -70,
            child: Image.asset(
              "assets/img_bg_pattern.png",
              width: 254,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 40,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIcons.fill.quotes,
                  size: 65,
                  color: Colors.white,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AutoSizeText(
                      content,
                      textAlign: textAlign ?? TextAlign.start,
                      maxLines: 5,
                      maxFontSize: 28,
                      minFontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      style: MyTypography.h2.copyWith(
                        fontSize: 28,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    if (authorAvatar == null)
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Text(
                            author[0],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(authorAvatar!),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            author,
                            style: MyTypography.body2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (authorJob != null) const SizedBox(height: 5),
                          if (authorJob != null)
                            Text(
                              authorJob!,
                              style: MyTypography.caption1.copyWith(
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
