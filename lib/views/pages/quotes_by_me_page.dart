import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../controllers/quotes_controller.dart';
import '../../utils/random_colors.dart';
import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';
import 'create_quote_page.dart';
import 'quote_detail_page.dart';

class QuotesByMePage extends ConsumerWidget {
  const QuotesByMePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesState = ref.watch(getQuotesProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: quotesState.when(
        data: (quotes) {
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
                final cardColor = getRandomColor();

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuoteDetailPage(
                          content: quotes[index].content!,
                          // "The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing.",
                          author: quotes[index].author!,
                          authorAvatar: "assets/img_avatar.png",
                          authorJob: "Co-Founder of The Walt Disney Company",
                          cardColor: cardColor,
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
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(height: 10),
                        AutoSizeText(
                          quotes[index].content!,
                          maxFontSize: 20,
                          minFontSize: 14,
                          maxLines: 15,
                          overflow: TextOverflow.ellipsis,
                          style: MyTypography.body2.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          quotes[index].author!,
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
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryDark,
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text("Something went wrong!"),
          );
        },
      ),
    );
  }
}
