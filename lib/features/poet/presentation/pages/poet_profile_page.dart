import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/poem/presentation/widgets/poem_list_widget.dart';
import 'package:qawafi_app/features/poet/presentation/widgets/poet_profile_card.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/widgets/appbar.dart';
import '../../../../core/common/widgets/background_image_scaffold.dart';
import '../bloc/poet_bloc/poet_bloc.dart';

class PoetProfilePage extends StatefulWidget {
  const PoetProfilePage({
    super.key,
    required this.poetId,
  });

  static const String routeName = 'PoetProfile';
  static route(String id) => MaterialPageRoute(
        builder: (context) => PoetProfilePage(poetId: id),
        settings: const RouteSettings(name: routeName),
      );

  final String poetId;
  @override
  State<PoetProfilePage> createState() => _PoetProfilePageState();
}

class _PoetProfilePageState extends State<PoetProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<PoetBloc>().add(PoetGoToDetails(poetId: widget.poetId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PoetBloc>().add(PoetNavigateBack());
        return true;
      },
      child: ScaffoldWithBackgroundImage(
          scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'تفاصيل الشاعر'),
        body: BlocConsumer<PoetBloc, PoetState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is PoetFailuer) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is PoetLoading) {
              return const Loader();
            }
            if (state is PoetProfile) {
              return Column(children: [
                PoetProfileCard(
                  imagePath: state.poet.imageSrc,
                  name: state.poet.fullName,
                  followers: state.poet.followers,
                  canFollow: state.poet.canFollow,
                  registrations: 20,
                  isUser: context.read<AppUserCubit>().state is AppUserLoggedIn,
                  onFollow: () {
                    context
                        .read<PoetBloc>()
                        .add(PoetFollow(poetId: state.poet.poetId));
                  },
                  onUnFollow: () {
                    context
                        .read<PoetBloc>()
                        .add(PoetUnFollow(poetId: state.poet.poetId));
                  },
                ),
                Expanded(
                  child: PoemList(
                    poemDataModel: state.poems,
                  ),
                ),
              ]);
            }
            return Container();
          },
        ),
      )),
    );
  }
}
