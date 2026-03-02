import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

import '../../../../core/constants/app_images.dart';
import '../../../customer/presentation/presentation/pages/wallet_page.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: AppPallete.secondaryColor),
        ),
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.wallet,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context, WalletPage.route());
          },
        ),
        automaticallyImplyLeading: false,

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: Image.asset(
              AppImages.LOGO,
              height: 60,
            ),
          )
        ],
        centerTitle: true,
        toolbarHeight: 120, // Adjust the height as needed

        // actions: ,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(120);
}
