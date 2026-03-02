import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/constants.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/SizeConfigPercentage.dart';
import 'package:qawafi_app/core/utils/check_access_level.dart';
import 'package:qawafi_app/features/libyan_titles/data/models/libyan_title_model.dart';
import 'package:qawafi_app/features/libyan_titles/presentation/bloc/libyan_title_bloc.dart';

import '../../data/models/poetic_verse_model.dart';

class LibyanTitlesPage extends StatefulWidget {
  const LibyanTitlesPage({super.key});

  static const String routeName = '/LibyanTitles';
  static route() => MaterialPageRoute(
        builder: (context) => const LibyanTitlesPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<LibyanTitlesPage> createState() => _LibyanTitlesPageState();
}

class _LibyanTitlesPageState extends State<LibyanTitlesPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _page++;
        log('Page ${_page}');
        _getData();
      }
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _getData() {
    context.read<LibyanTitleBloc>().add(
          LibyanTitleFetchEvent(pageNo: _page),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const QawafiAppBar(title: "مسميات ليبية"),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Cairo'),
        child: BlocConsumer<LibyanTitleBloc, LibyanTitleState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LibyanTitleFailure) {
              return Refresh(
                  message: state.message, onRefresh: () => _getData());
            }
            if (state is LibyanTitleLoading) {
              return const Loader();
            }
            if (state is LibyanTitleLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: state.libyans.length,
                      itemBuilder: (context, titlesIndex) {
                        return TitleItem(
                          libyanTitleModel: state.libyans[titlesIndex],
                          index: titlesIndex,
                          isFree: state.libyans[titlesIndex].isFree,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    ),
                  ),
                  if (state.loadingMore) ...{
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Loader(),
                    ),
                  },
                ],
              );
            }
            return Container();
          },
        ),
      ),
    ));
  }
}

class TitleItem extends StatefulWidget {
  const TitleItem({
    super.key,
    required this.libyanTitleModel,
    required this.index,
    required this.isFree,
  });
  final LibyanTitleModel libyanTitleModel;
  final int index;
  final bool isFree;
  @override
  State<TitleItem> createState() => _TitleItemState();
}

class _TitleItemState extends State<TitleItem> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        checkAccessLevel(
            context: context, function: _setExpanded, isFree: widget.isFree);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isExpanded
            ? 60
            : SizeConfigPercentage.blockSizeVertical! *
                Constants.libyanTitlesItemHieght,
        width: double.infinity,
        child: _isExpanded
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.only(
                  right: 8,
                  // top: 8,
                  // bottom: 8,
                ),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF3A3A3A).withOpacity(0.4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppPallete.libyanTitlesCardsTitleColor,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.libyanTitleModel.title,
                        style: const TextStyle(
                            fontSize: 24,
                            color: AppPallete.libyanTitlesCardsTitleColor),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                    if (widget.isFree)
                      // const Align(
                      //     alignment: Alignment.topCenter,
                      //     child: Icon(Icons.bookmark)),
                      Container(
                        width: 25,
                        decoration: BoxDecoration(
                            color: AppPallete.secondaryColor.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Center(
                            child: Text(
                              'مجاني',
                              style: TextStyle(
                                  color: AppPallete.blackColor.withOpacity(1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 15,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(8),
                      height: SizeConfigPercentage.blockSizeVertical! *
                              Constants.libyanTitlesItemHieght -
                          30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppPallete.secondaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            Text(widget.libyanTitleModel.description),
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  widget.libyanTitleModel.poeticVerses.length,
                              itemBuilder: (context, index) {
                                return PoeticVerses(
                                  poeticVerse: widget.libyanTitleModel
                                      .poeticVerses[index] as PoeticVerseModel,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 20,
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppPallete.primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        widget.libyanTitleModel.title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _setExpanded() {
    _isExpanded = !_isExpanded;
    setState(() {});
  }
}

class PoeticVerses extends StatelessWidget {
  const PoeticVerses({
    super.key,
    required this.poeticVerse,
  });

  final PoeticVerseModel poeticVerse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF5E4F30),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Text(poeticVerse.verse),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
