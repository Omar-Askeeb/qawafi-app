import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/features/quatrains/presentation/widgets/quatrain_list_widget.dart';
import 'package:qawafi_app/features/quatrains_category/domain/entites/quatrains_category.dart';

import '../bloc/quatrain/quatrain_bloc.dart';

class QuatrainsPage extends StatefulWidget {
  const QuatrainsPage({
    super.key,
    required this.category,
  });
  final QuatrainsCategory category;
  static const String routeName = 'Quatrains';

  static route(QuatrainsCategory category) => MaterialPageRoute(
        builder: (context) => QuatrainsPage(category: category),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<QuatrainsPage> createState() => _QuatrainsPageState();
}

class _QuatrainsPageState extends State<QuatrainsPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    context.read<QuatrainBloc>().add(
          QuatrainFetchData(
            pageNo: 1,
            pageSize: 100,
            categoryId: widget.category.quatrainsCategoryId,
            query: textEditingController.text,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: QawafiAppBar(title: widget.category.title),
      body: Column(
        children: [
          BlocConsumer<QuatrainBloc, QuatrainState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is QuatrainFailure) {
                return Refresh(
                  message: state.message,
                  onRefresh: () => context.read<QuatrainBloc>().add(
                        QuatrainFetchData(
                          pageNo: 1,
                          pageSize: 100,
                          categoryId: widget.category.quatrainsCategoryId,
                          query: textEditingController.text,
                        ),
                      ),
                );
              }
              if (state is QuatrainLoading) {
                return const Loader();
              }
              if (state is QuatrainSuccess) {
                return Expanded(
                  child: QuatrainList(
                    quatrains: state.quatrains,
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    ));
  }
}
