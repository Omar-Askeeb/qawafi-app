import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/features/poet/presentation/pages/poet_profile_page.dart';

import '../../../../core/common/widgets/refresh.dart';
import '../../../../core/utils/nav_index_singleton.dart';
import '../../../poem/presentation/widgets/search_bar.dart';
import '../bloc/poet_bloc/poet_bloc.dart';
import '../widgets/poet_grid.dart';

class PoetPage extends StatefulWidget {
  const PoetPage({super.key});
  static const String routeName = 'Poet';
  static route() => MaterialPageRoute(
        builder: (context) => const PoetPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<PoetPage> createState() => _PoetPageState();
}

class _PoetPageState extends State<PoetPage> {
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _performSearch();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        // _startVideo();
      }
    });
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies Poet');
  }

  @override
  void didUpdateWidget(covariant PoetPage oldWidget) {
    // TODO: implement didUpdateWidget
    log('didUpdateWidget Poet');
    super.didUpdateWidget(oldWidget);
    if (NavSingleton().intValue != 1) {
      return;
    }
    _performSearch();
    // Add a listener to the text controller
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
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      _page = 1;
      _performSearch();
    });
  }

  _performSearch() {
    // Your search logic here
    context.read<PoetBloc>().add(
          PoetGetPoets(
            query: _searchController.text,
            pageNo: _page,
          ),
        );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   context.read<PoetBloc>().add(PoetGetPoets());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    log(ModalRoute.of(context)?.settings.name ?? 'UNK');

    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const QawafiAppBar(title: 'الشعراء'),
      body: Column(children: [
        AppSearchBar(
          controller: _searchController,
          isEnabled: true,
        ),
        Expanded(
          child: BlocConsumer<PoetBloc, PoetState>(
            listener: (context, state) {
              if (state is PoetProfile) {
                log('Page : ${ModalRoute.of(context)?.settings.name}');
                if (ModalRoute.of(context)?.settings.name !=
                    PoetProfilePage.routeName) {
                  // Navigator.push(
                  //   context,
                  //   PoetProfilePage.route(),
                  // );
                }
              }
              // if (state is PoetFailuer) {
              //   showSnackBar(context, state.message);
              // }
            },
            builder: (context, state) {
              if (state is PoetFailuer) {
                return Refresh(
                  message: state.message,
                  onRefresh: () => _performSearch(),
                );
              }
              if (state is PoetLoading) {
                return const Loader();
              }
              if (state is PoetSuccess) {
                return Column(
                  children: [
                    Expanded(
                      child: PoetGrid(
                        scrollController: _scrollController,
                        poets: state.poets,
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
      ]),
    ));
  }
}
