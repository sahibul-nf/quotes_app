import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../controllers/favorite_controller.dart';
import '../pages/quote_detail_page.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/empty_state.dart';
import '../widgets/icon_solid_light.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteQuotesState = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 66,
        titleSpacing: 20,
        title: Text(
          "Favorites",
          style: MyTypography.h3,
        ),
        actions: [
          favoriteQuotesState.isLoading
              ? UnconstrainedBox(
                  child: ClipRRect(
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
                  ),
                )
              : IconSolidLight(
                  icon: PhosphorIcons.regular.trashSimple,
                  onTap: () {
                    ref
                        .read(favoriteProvider.notifier)
                        .deleteAllFavoriteQuotes();
                  },
                ),
          const SizedBox(width: 20),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          ref.refresh(favoriteProvider);
          return Future.value();
        },
        child: favoriteQuotesState.when(
          data: (quotes) {
            if (quotes == null || quotes.isEmpty) {
              return const EmptyState(
                description: "No quotes created yet",
              );
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemCount: quotes.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                staggeredTileBuilder: (index) {
                  return const StaggeredTile.fit(1);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuoteDetailPage(
                            quote: quotes[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Color(quotes[index].backgroundColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            PhosphorIcons.fill.quotes,
                            color: Color(quotes[index].textColor),
                            size: 32,
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                            quotes[index].content,
                            maxFontSize: 20,
                            minFontSize: 14,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            textAlign: quotes[index].textAlign,
                            style: GoogleFonts.getFont(
                              quotes[index].fontFamily,
                              color: Color(quotes[index].textColor),
                              fontSize: quotes[index].fontSize,
                              fontWeight: quotes[index].fontWeight,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            quotes[index].author,
                            textAlign: TextAlign.center,
                            style: MyTypography.body2.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryDark,
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return const SingleChildScrollView(
              child: Center(
                child: Text("Something went wrong!"),
              ),
            );
          },
        ),
      ),
    );
  }
}
