import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/quote_model.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';

class QuotWidgetShare extends StatelessWidget {
  const QuotWidgetShare({
    super.key,
    required this.quote,
    required this.height,
    required this.width,
    this.showBackgroundPattern = false,
  });
  final Quote quote;
  final double height;
  final double width;
  final bool showBackgroundPattern;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(quote.backgroundColor),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Stack(
        children: [
          // Background pattern
          if (showBackgroundPattern)
            Positioned(
              left: 168 + 30,
              top: -70 - 10,
              child: Image.asset(
                "assets/img_bg_pattern.png",
                width: 254,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              children: [
                Icon(
                  PhosphorIcons.fill.quotes,
                  size: 70,
                  color: Color(quote.textColor),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: AutoSizeText(
                    quote.content,
                    maxFontSize: 28,
                    minFontSize: 18,
                    maxLines: 10,
                    textAlign: quote.textAlign,
                    style: GoogleFonts.getFont(
                      quote.fontFamily,
                      color: Color(quote.textColor),
                      fontSize: quote.fontSize ?? 28,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (quote.avatar == null)
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 35,
                        width: 35,
                        child: Center(
                          child: Text(
                            quote.author[0],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(quote.avatar!),
                      ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            quote.author,
                            maxLines: 1,
                            style: MyTypography.body2.copyWith(
                              color: Color(quote.textColor),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (quote.profession != null &&
                              quote.profession != "")
                            const SizedBox(height: 5),
                          if (quote.profession != null &&
                              quote.profession != "")
                            Text(
                              quote.profession!,
                              style: MyTypography.body2.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(quote.textColor),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
