import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';

import '../bloc/quatrains_category_bloc.dart';
import '../widgets/quatrains_category_grid.dart';

class QuatrainCategoryPage extends StatefulWidget {
  static const String routeName = 'QuatrainCategory';

  static route() => MaterialPageRoute(
        builder: (context) => const QuatrainCategoryPage(),
        settings: const RouteSettings(name: routeName),
      );
  const QuatrainCategoryPage({super.key});

  @override
  State<QuatrainCategoryPage> createState() => _QuatrainCategoryPageState();
}

int page = 1;
int pageSize = 2147483647;
TextEditingController _searchController = TextEditingController();

class _QuatrainCategoryPageState extends State<QuatrainCategoryPage> {
  @override
  void initState() {
    context.read<QuatrainsCategoryBloc>().add(
          QuatrainsCategoryFetch(
            pageNo: page,
            pageSize: pageSize,
            query: _searchController.text,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'رباعيات'),
        body: Container(
          child: Column(
            children: [
              BlocConsumer<QuatrainsCategoryBloc, QuatrainsCategoryState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is QuatrainsCategoryFailure) {
                    return Refresh(
                        message: state.message,
                        onRefresh: () =>
                            context.read<QuatrainsCategoryBloc>().add(
                                  QuatrainsCategoryFetch(
                                      pageNo: page,
                                      pageSize: pageSize,
                                      query: _searchController.text),
                                ));
                  }
                  if (state is QuatrainsCategoryLoading) {
                    return const Loader();
                  }
                  if (state is QuatrainsCategorySuccess) {
                    log(state.list.length.toString());
                    log(state.list[0].imageSrc);

                    return Expanded(
                      child: DynamicHeightGridView(
                        imageUrls: state.list,
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
