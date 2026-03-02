import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_icons.dart';

import '../../../../core/theme/app_pallete.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key, this.isEnabled = false, this.controller});
  final TextEditingController? controller;
  final isEnabled;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        enabled: widget.isEnabled,
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: AppIcon.search,
          hintText: "بحث",
          hintStyle: const TextStyle(color: AppPallete.whiteColor),
          filled: true,
          fillColor: AppPallete.searchBarColor,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppPallete.transparentColor,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
