import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

class QuoteDetailPage extends StatelessWidget {
  const QuoteDetailPage({
    super.key,
    required this.content,
    required this.author,
    required this.authorAvatar,
    required this.authorJob,
  });
  final String content;
  final String author;
  final String authorAvatar;
  final String authorJob;

  @override
  Widget build(BuildContext context) {
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
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Column(
          children: [
            Icon(
              PhosphorIcons.fill.quotes,
              size: 70,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AutoSizeText(
                content,
                maxFontSize: 28,
                minFontSize: 18,
                maxLines: 10,
                textAlign: TextAlign.center,
                style: MyTypography.body1.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(authorAvatar),
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
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        authorJob,
                        style: MyTypography.caption1.copyWith(
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 70),
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
