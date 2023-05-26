import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../controllers/favorite_controller.dart';
import '../../models/quote_model.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

class QuoteDetailPage extends ConsumerWidget {
  const QuoteDetailPage({
    super.key,
    required this.quote,
  });

  final Quote quote;

  void onTapFavorite(bool isFavorite, WidgetRef ref) {
    print(isFavorite);

    ref
        .read(favoriteProvider.notifier)
        .toggleFavorite(quote, isFavorite)
        .then((_) {
      ref.refresh(favoriteProvider);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteQuotesState = ref.watch(favoriteProvider);

    final isFavorite = ref.watch(favoriteProvider.notifier).isFavorite(quote);

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
          color: Color(quote.backgroundColor),
          borderRadius: BorderRadius.circular(36),
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
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quote.author,
                        style: MyTypography.body2.copyWith(
                          color: Color(quote.textColor),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (quote.profession != null) const SizedBox(height: 5),
                      if (quote.profession != null)
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
                )
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (quote.id != null)
                  favoriteQuotesState.isLoading
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            color: MyColors.secondary,
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: MyColors.primaryDark,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        )
                      : IconSolidLight(
                          onTap: () => onTapFavorite(isFavorite, ref),
                          icon: isFavorite
                              ? PhosphorIcons.fill.heart
                              : PhosphorIcons.regular.heart,
                        ),
                if (quote.id != null) const SizedBox(width: 16),
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
