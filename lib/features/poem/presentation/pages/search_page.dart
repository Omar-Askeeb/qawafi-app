import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/search/poem_search_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/widgets/poem_list_widget.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/enums/search_keys.dart';
import '../widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  int selectedIndex = 0;
  SearchKeys searchKeys = SearchKeys.name;
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Add a listener to the text controller
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _page++;
        log(_page.toString());
        _performSearch();
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    // Cancel the previous timer if it exists

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer
    _debounce = Timer(const Duration(seconds: 1), () {
      // Execute your search function here
      // _performSearch(_searchController.text);
      log('_performSearch');
      _page = 1;
      _performSearch();
    });
  }

  _performSearch() {
    // Your search logic here
    context.read<PoemSearchBloc>().add(
          PerformSearch(
            query: _searchController.text,
            searchKeys: searchKeys,
            pageNo: _page,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              AppSearchBar(
                isEnabled: true,
                controller: _searchController,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Make the list horizontal
                  itemCount: SearchKeys.values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomButton(
                        text: Constants.searchByMap[SearchKeys.values[index]] ??
                            '',
                        isSelected: selectedIndex == index,
                        onPressed: () {
                          setSelected(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              BlocConsumer<PoemSearchBloc, PoemSearchState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is PoemSearchFailure) {
                    showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is PoemSearchLoading) {
                    return const Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Loader()
                      ],
                    );
                  }
                  if (state is PoemSearchFailure) {
                    return Refresh(
                        message: state.message, onRefresh: _performSearch);
                  }
                  if (state is PoemSearchSuccess) {
                    return Expanded(
                      child: PoemList(
                        poemDataModel: state.PoemSearchResults,
                        scrollController: _scrollController,
                      ),
                    );
                    // return Column(
                    //   children: [
                    //     Flexible(
                    //         fit: FlexFit.loose,
                    //         child: PoemList(
                    //             poemDataModel: state.PoemSearchResults)),
                    //   ],
                    // );
                  }

                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.LOGO,
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "الرجاء إدخال نص للبحث",
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  setSelected(int index) {
    print('object');
    setState(() {
      selectedIndex = index;
    });
    searchKeys = SearchKeys.values[index];

    _performSearch();
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onPressed;
  const CustomButton({
    required this.text,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: !isSelected
            ? AppPallete.secondaryColor
            : AppPallete.primaryColor, // Set the button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black, // Text color
          fontSize: 16,
        ),
      ),
    );
  }
}


  // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(300),
      //   child: AppBar(
      //     title: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const AppSearchBar(isEnabled: true),
      //         Container(
      //           margin: const EdgeInsets.only(top: 10),
      //           height: 40,
      //           width: double.infinity,
      //           child: ListView.builder(
      //             scrollDirection: Axis.horizontal, // Make the list horizontal
      //             itemCount: buttonTexts.length,
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //                 child: CustomButton(text: buttonTexts[index]),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //     centerTitle: true,
      //     // leading: const Padding(
      //     //   padding: EdgeInsets.all(8.0),
      //     //   child: AppIcon.search,
      //     // ),
      //     toolbarHeight: 200,
      //   ),
      // ),