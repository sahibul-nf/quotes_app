import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

class QuoteDetailPage extends ConsumerWidget {
  const QuoteDetailPage({
    super.key,
    required this.content,
    required this.author,
    required this.authorAvatar,
    required this.authorJob,
    this.fontFamily,
    this.fontSize = 24,
    this.textAlign = TextAlign.center,
    this.cardColor,
    this.textColor,
  });
  final String content;
  final String author;
  final String authorAvatar;
  final String? authorJob;
  final Color? cardColor;
  final Color? textColor;
  final TextAlign textAlign;
  final double fontSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 76,
        leading: IconSolidLight(
          icon: PhosphorIcons.regular.caretLeft,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "Quote Detail",
          style: MyTypography.h3,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            Icon(
              PhosphorIcons.fill.quotes,
              size: 70,
              color: textColor,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AutoSizeText(
                content,
                maxFontSize: 28,
                minFontSize: 18,
                maxLines: 10,
                textAlign: textAlign,
                style: GoogleFonts.getFont(
                  fontFamily!,
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(authorAvatar),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: MyTypography.body2.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (authorJob != null || authorJob != "")
                        const SizedBox(height: 5),
                      if (authorJob != null)
                        Text(
                          authorJob!,
                          style: MyTypography.body2.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconSolidLight(
                  icon: PhosphorIcons.fill.heart,
                ),
                const SizedBox(width: 16),
                // share button with icon
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(PhosphorIcons.fill.shareFat),
                  label: const Text("Share"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
