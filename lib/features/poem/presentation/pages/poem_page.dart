import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/poem/presentation/widgets/poem_list_widget.dart';
import 'package:qawafi_app/features/purpose/domain/entites/purpose.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../bloc/poem/poem_bloc.dart';

class PoemPage extends StatefulWidget {
  const PoemPage({super.key, required this.purpose});

  static const String routeName = 'Poem';

  final Purpose purpose;
  static route({required Purpose purpose}) => MaterialPageRoute(
        builder: (context) => PoemPage(purpose: purpose),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<PoemPage> createState() => _PoemPageState();
}

class _PoemPageState extends State<PoemPage> {
  int _category = 0;
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  @override
  void initState() {
    // TODO: implement initState
    // log((context.read<PoemBloc>().state as PoemSuccess).purpose);
    if (context.read<PoemBloc>().state is PoemSuccess &&
        widget.purpose.purposeName ==
            (context.read<PoemBloc>().state as PoemSuccess).purpose) {
      _category = (context.read<PoemBloc>().state as PoemSuccess).category;
    } else {
      _fetchPoem();
    }
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  void _fetchPoem() {
    context.read<PoemBloc>().add(PoemGetByPurposeAndCategory(
          category: _category == 0 ? 'Recite' : 'Melhona',
          purpose: widget.purpose,
          pageNo: _page,
        ));
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _page++;
        log(_page.toString());
        _fetchPoem();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(title: widget.purpose.purposeName),
        body: Container(
          width: double.infinity,
          child: Column(children: [
            ToggleSwitch(
              minWidth: getProportionateScreenWidth(327),
              minHeight: getProportionateScreenHeight(50),
              cornerRadius: 50.0,
              inactiveFgColor: AppPallete.secondaryColor,
              activeBgColor: const [AppPallete.secondaryColor],
              inactiveBgColor: AppPallete.blackColor,
              activeFgColor: AppPallete.blackColor,
              radiusStyle: true,

              initialLabelIndex: _category,

              doubleTapDisable: false, // re-tap active widget to de-activate
              totalSwitches: 2,

              labels: const [
                'إلـــقـــاء',
                'ملــــحــون',
              ],

              onToggle: (index) {
                _category = index ?? 0;
                _page = 1;
                _fetchPoem();
              },
            ),
            BlocConsumer<PoemBloc, PoemState>(
              listener: (context, state) {
                if (state is PoemFailure) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is PoemLoading) {
                  return const Expanded(
                    child: Center(
                      child: Loader(),
                    ),
                  );
                }
                if (state is PoemSuccess) {
                  return Expanded(
                    child: PoemList(
                      scrollController: _scrollController,
                      poemDataModel: state.poemDataModel,
                    ),
                  );
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
