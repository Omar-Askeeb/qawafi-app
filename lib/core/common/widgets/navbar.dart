import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

class QawafiNavBar extends StatelessWidget implements PreferredSizeWidget {
  const QawafiNavBar(this.selectedIndex, this.onTap, this.isLoggedIn);

  final int selectedIndex;
  final Function onTap;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.transparentColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: GNav(
          // backgroundColor: Colors.red,

          onTabChange: (index) => onTap(index),
          selectedIndex: selectedIndex,
          gap: 8,
          activeColor: Colors.white,
          color: const Color.fromRGBO(233, 195, 120, 1),
          iconSize: 30,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          duration: const Duration(milliseconds: 800),
          tabBackgroundColor: Color.fromRGBO(76, 64, 40, 1),
          // tabBackgroundColor: Color.fromRGBO(76, 64, 40, 1),
          textStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          tabs: [
            const GButton(
              icon: Icons.home_outlined,
              // text: 'الرئيسية',
            ),
            const GButton(
              icon: Icons.people_alt_outlined,
              // text: 'شعراء',
            ),
            const GButton(
              icon: Icons.play_circle,
              // text: 'Reels',
            ),
            if (isLoggedIn)
              const GButton(
                icon: Icons.favorite_border,
                // text: 'مفضلة',
              ),
            const GButton(
              icon: Icons.person,
              // icon: Icons.person_outline,
              // text: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
