import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/views/widgets/empty_state.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../controllers/quotes_controller.dart';
import '../../models/quote_model.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';
import 'create_quote_page.dart';
import 'quote_detail_page.dart';

class QuotesByMePage extends ConsumerWidget {
  const QuotesByMePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesState = ref.watch(quotesProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 66,
        titleSpacing: 20,
        title: Text(
          "Created by you",
          style: MyTypography.h3,
        ),
        actions: [
          IconSolidLight(
            icon: PhosphorIcons.regular.plus,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateQuotePage(),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.value(ref.refresh(quotesProvider));
        },
        child: quotesState.when(
          skipLoadingOnRefresh: true,
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
                  final cardColor = Color(quotes[index].backgroundColor);
                  final textColor = Color(quotes[index].textColor);

                  return InkWell(
                    onLongPress: () => onLongPressCard(
                      context,
                      quotes[index],
                      ref,
                    ),
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
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            PhosphorIcons.fill.quotes,
                            color: textColor,
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
                              color: textColor,
                              fontSize: quotes[index].fontSize,
                              fontWeight: quotes[index].fontWeight,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            quotes[index].author,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: MyTypography.body2.copyWith(
                              color: textColor,
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

  void onLongPressCard(BuildContext context, Quote quote, ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          // height: 200,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: implement edit quote
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const CreateQuotePage(
                  //         // quote: quotes[index],
                  //         ),
                  //   ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.regular.pencil,
                        color: MyColors.primaryDark,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Edit",
                        style: MyTypography.body1.copyWith(
                          color: MyColors.primaryDark,
                        ),
                      ),
                      // this feat is coming soon
                      const Spacer(),
                      Chip(
                        backgroundColor: MyColors.secondary,
                        label: Text(
                          "Coming soon",
                          style: MyTypography.caption1.copyWith(
                            color: MyColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  ref
                      .read(quotesProvider.notifier)
                      .deleteQuote(quote)
                      .then((_) {
                    ref.invalidate(quotesProvider);
                    ref.invalidate(favoriteProvider);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.regular.trashSimple,
                        color: MyColors.primaryDark,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Delete",
                        style: MyTypography.body1.copyWith(
                          color: MyColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
