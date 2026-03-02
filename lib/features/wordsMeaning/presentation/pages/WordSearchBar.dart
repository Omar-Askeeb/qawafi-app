import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/features/wordsMeaning/presentation/bloc/word_bloc.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_pallete.dart';

class WordSearchBar extends StatefulWidget {
  const WordSearchBar({super.key, this.isEnabled = true, this.controller});
  final TextEditingController? controller;
  final bool isEnabled;

  @override
  State<WordSearchBar> createState() => _WordSearchBarState();
}

class _WordSearchBarState extends State<WordSearchBar> {
  late TextEditingController? _controller;

  @override
  void initState() {
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
        onChanged: (query) {
          context.read<WordBloc>().add(GetWordsEvent(pageNumber: 1, pageSize: 10, isFirstFetch: true, query: query));
        },
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
