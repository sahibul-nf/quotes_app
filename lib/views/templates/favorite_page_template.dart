import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../utils/random_colors.dart';
import '../pages/quote_detail_page.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "Lorem ipsum dolor sit amet."
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 66,
        titleSpacing: 20,
        title: Text(
          "Favorites",
          style: MyTypography.h3,
        ),
        actions: [
          IconSolidLight(
            icon: PhosphorIcons.regular.trashSimple,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        itemCount: items.length,
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
                    content: items[index],
                    // "The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing. The best way to get started is to quit talking and begin doing.",
                    author: 'John Doe',
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
                    items[index],
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
                    "John Doe",
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
  }
}
