import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/controllers/search_quotes_controller.dart';
import 'package:quotes_app/views/themes/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/quote_model.dart';
import '../../utils/random_colors.dart';
import '../pages/quote_detail_page.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchQuotesState = ref.watch(searchQuotesProvider);

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
          "Search Quote",
          style: MyTypography.h3,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 0.0,
            ),
            decoration: BoxDecoration(
              color: MyColors.secondary,
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.only(
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Center(
              child: IntrinsicWidth(
                child: TextField(
                  controller: _searchController,
                  cursorColor: MyColors.black,
                  decoration: InputDecoration(
                    hintText: "Find a quote here",
                    hintStyle: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      PhosphorIcons.regular.magnifyingGlass,
                      color: MyColors.black,
                    ),
                  ),
                  onChanged: (value) {
                    // check if value is not empty and delay searching
                    if (value.isNotEmpty &&
                        value.length >= 3 &&
                        !searchQuotesState.isLoading) {
                      Future.delayed(const Duration(milliseconds: 700), () {
                        ref
                            .read(searchQuotesProvider.notifier)
                            .searchQuotes(_searchController.text);
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: searchQuotesState.when(
        data: (quotes) {
          if (quotes == null) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Icon(
                      PhosphorIcons.fill.quotes,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "It's empty here",
                    style: MyTypography.h2,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Try to find a quote by typing the keyword in the search bar above",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (quotes.isEmpty) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.secondary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Icon(
                      PhosphorIcons.fill.quotes,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "No quotes found",
                    style: MyTypography.h2,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Try searching for something else",
                    style: MyTypography.body1.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return StaggeredGridView.countBuilder(
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
                  final quote = Quote(
                    author: quotes[index].author!,
                    content: quotes[index].content!,
                    backgroundColor: cardColor.value,
                    textColor: Colors.white.value,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    userId: '',
                    profession: '',
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuoteDetailPage(
                        quote: quote,
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
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
