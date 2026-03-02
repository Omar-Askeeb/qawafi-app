import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/features/favorite/data/models/favorite_display_model.dart';
import 'package:qawafi_app/features/favorite/presentation/bloc/favorites_bloc.dart';
import 'package:qawafi_app/features/favorite/presentation/widgets/favorite_list_widget.dart';

import '../../../../core/utils/nav_index_singleton.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  void didUpdateWidget(FavoritesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (NavSingleton().intValue != 3) {
      return;
    }
    getData();
  }

  void getData() async {
    context.read<FavoritesBloc>().add(FavoriteFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: "المفضلات"),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: DefaultTextStyle(
            style: const TextStyle(fontFamily: 'Cairo'),
            child: BlocConsumer<FavoritesBloc, FavoritesState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return const Loader();
                }
                if (state is FavoritesFailure) {
                  // if(){
                  //   return
                  // }
                  return Refresh(
                    message: state.message,
                    onRefresh: () => context.read<FavoritesBloc>().add(
                          FavoriteFetchEvent(),
                        ),
                  );
                }
                if (state is FavoritesSuccess) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FavoriteItem(
                          title: "قصائد",
                          data: List<FavoriteDisplayModel>.generate(
                            state.poems.length,
                            (index) => FavoriteDisplayModel(
                              title: state.poems[index].title,
                              subTitle: state.poems[index].description,
                              path: state.poems[index].fileSrc,
                              duration: state.poems[index].duration,
                              isFree: state.poems[index].isFree,
                            ),
                          ),
                          originalData: state.poems,
                        ),
                        FavoriteItem(
                          title: "رباعيات",
                          data: List<FavoriteDisplayModel>.generate(
                            state.quatrains.length,
                            (index) => FavoriteDisplayModel(
                              title: state.quatrains[index].title,
                              subTitle: state.quatrains[index].quatrainsCategory
                                      ?.title ??
                                  '',
                              path: state.quatrains[index].trackSrc,
                              duration: state.quatrains[index].duration,
                              isFree: false,
                            ),
                          ),
                          originalData: state.quatrains,
                        ),
                        FavoriteItem(
                          title: "حكاية مثل",
                          data: List<FavoriteDisplayModel>.generate(
                            state.proverbs.length,
                            (index) => FavoriteDisplayModel(
                              title: state.proverbs[index].title,
                              subTitle: state.proverbs[index].description,
                              path: state.proverbs[index].trackSrc,
                              duration: state.proverbs[index].duration,
                              isFree: false,
                            ),
                          ),
                          originalData: state.proverbs,
                        ),
                      ]);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.title,
    required this.data,
    required this.originalData,
  });

  final List<FavoriteDisplayModel> data;
  final String title;
  final dynamic originalData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: FavoriteList(
              data: data,
              originalData: originalData,
            ),
          ),
        ],
      ),
    );
  }
}
