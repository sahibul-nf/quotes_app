import 'package:flutter/material.dart';
import 'package:quotes_app/views/themes/colors.dart';
import 'package:quotes_app/pages/my_profile_page.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

enum _SelectedTab { quotes, create, favorite, profile }

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  _SelectedTab _selectedTab = _SelectedTab.quotes;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _SelectedTab.values.indexOf(_selectedTab),
        children: [
          Container(
            color: MyColors.primary,
          ),
          Container(
            color: MyColors.secondary,
          ),
          Container(
            color: MyColors.primary,
          ),
          const MyProfile(),
          Container(
            color: MyColors.secondary,
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTap: _handleIndexChanged,
        dotIndicatorColor: MyColors.black,
        backgroundColor: MyColors.secondary,
        // enableFloatingNavBar: false,
        paddingR: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        enablePaddingAnimation: false,
        items: [
          DotNavigationBarItem(
            icon: Image.asset(
              _selectedTab == _SelectedTab.quotes
                  ? "assets/ic_quotes_filled.png"
                  : "assets/ic_quotes_outlined.png",
              width: 24,
            ),
          ),
          DotNavigationBarItem(
            icon: Image.asset(
              _selectedTab == _SelectedTab.create
                  ? "assets/ic_create_filled.png"
                  : "assets/ic_create_outlined.png",
              width: 24,
            ),
          ),
          DotNavigationBarItem(
            icon: Image.asset(
              _selectedTab == _SelectedTab.favorite
                  ? "assets/ic_favorite_filled.png"
                  : "assets/ic_favorite_outlined.png",
              width: 24,
            ),
          ),
          DotNavigationBarItem(
            icon: Image.asset(
              _selectedTab == _SelectedTab.profile
                  ? "assets/ic_user_filled.png"
                  : "assets/ic_user_outlined.png",
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
