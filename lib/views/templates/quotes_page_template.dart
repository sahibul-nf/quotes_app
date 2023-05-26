import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/quote_model.dart';
import '../pages/quote_detail_page.dart';
import '../pages/search_page.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';
import '../widgets/quotes_card.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            centerTitle: false,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconSolidLight(
                  icon: PhosphorIcons.regular.magnifyingGlass,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                ),
              ),
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
                        author: 'Rick Riordan',
                        content:
                            'The best way to get started is to quit talking and begin doing.',
                        backgroundColor: Colors.blue.value,
                        textColor: Colors.white.value,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        userId: '',
                        profession: 'CEO of The Walt Disney Company',
                      );

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuoteDetailPage(
                            quote: quote,
                          ),
                        ),
                      );
                    },
                    child: const QuotesCard(
                      author: "Rick Riordan",
                      authorAvatar: "assets/img_avatar.png",
                      authorJob: "Co-Founder of The Walt Disney Company",
                      content:
                          "The best way to get started is to quit talking and begin doing.",
                    ),
                  ),
                );
              },
              childCount: 7,
            ),
          )
        ],
      ),
    );
  }
}
