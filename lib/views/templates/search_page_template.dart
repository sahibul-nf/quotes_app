import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/colors.dart';
import '../themes/typography.dart';
import '../widgets/icon_solid_light.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
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
      ),
    );
  }
}
