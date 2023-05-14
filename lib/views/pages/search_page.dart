import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quotes_app/views/themes/colors.dart';

import '../themes/typography.dart';
import '../widgets/my_leading.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const MyLeading(),
        title: Text(
          "Search Quote",
          style: MyTypography.h3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: Column(
          children: [
            // Search bar
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0.0,
              ),
              decoration: BoxDecoration(
                color: MyColors.secondary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: IntrinsicWidth(
                  child: TextField(
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
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
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
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
