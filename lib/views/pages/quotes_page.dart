import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/controllers/quotes_controller.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:quotes_app/utils/random_colors.dart';
import 'package:quotes_app/views/pages/quote_detail_page.dart';
import 'package:quotes_app/views/pages/search_page.dart';
import 'package:quotes_app/views/themes/colors.dart';
import 'package:quotes_app/views/themes/typography.dart';
import 'package:quotes_app/views/widgets/icon_solid_light.dart';
import 'package:quotes_app/views/widgets/quotes_card.dart';

class QuotesPage extends ConsumerWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesState = ref.watch(getQuotesProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            centerTitle: false,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              IconSolidLight(
                icon: PhosphorIcons.regular.magnifyingGlass,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
            title: Text("Quotes", style: MyTypography.h2),
            expandedHeight: 116,
            elevation: 0,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1.0,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              title: Text(
                "Quotes",
                style: MyTypography.h2,
              ),
            ),
          ),
          SliverList(
            delegate: quotesState.when(
              data: (quotes) {
                return SliverChildBuilderDelegate(
                  childCount: quotes.length,
                  (context, index) {
                    final cardColor = getRandomColor();

                    return Padding(
                      padding: EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: 16,
                        top: index == 0 ? 100 : 0,
                      ),
                      child: InkWell(
                        onTap: () {
                          final quote = Quote(
                            author: quotes[index].author!,
                            content: quotes[index].content!,
                            backgroundColor: cardColor.value,
                            textColor: Colors.white.value,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.left,
                            userId: '8e19a942-adc3-4cbd-ae0d-ce4251e0d3e4',
                          );

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => QuoteDetailPage(
                                quote: quote,
                              ),
                            ),
                          );
                        },
                        child: QuotesCard(
                          color: cardColor,
                          author: quotes[index].author!,
                          content: quotes[index].content!,
                          // "The best way to get started is to quit talking and begin doing.",
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => SliverChildListDelegate.fixed(
                [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
              error: (error, stackTrace) => SliverChildListDelegate.fixed(
                [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: Text("Something went wrong!")),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
