import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';
import 'package:qawafi_app/features/spoken_proverbs/presentation/pages/widgets/spoken_proverbs_list_widget.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/constants/app_images.dart';
import '../bloc/spoken_proverb_bloc/spoken_proverb_bloc.dart';

class SpokenProverbPage extends StatefulWidget {
  const SpokenProverbPage({super.key, required this.spokenCategory});

  static const String routeName = 'SpokenProverb';

  static route({required SpokenProverbCategoryModel spokenCategory}) =>
      MaterialPageRoute(
        builder: (context) => SpokenProverbPage(spokenCategory: spokenCategory),
        settings: const RouteSettings(name: routeName),
      );
  final SpokenProverbCategoryModel spokenCategory;

  @override
  State<SpokenProverbPage> createState() => _SpokenProverbPageState();
}

class _SpokenProverbPageState extends State<SpokenProverbPage> {
  @override
  void initState() {
    context.read<SpokenProverbBloc>().add(SpokenProverbFetchEvent(
        categoryId: widget.spokenCategory.spokenProverbsCategoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
          title: widget.spokenCategory.title,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: BlocConsumer<SpokenProverbBloc, SpokenProverbState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is SpokenProverbFailure) {
                    if (context.read<AppUserCubit>().state
                        is! AppUserLoggedIn) {
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // الشعار
                            Image.asset(
                              AppImages.LOGO,
                              height: 150,
                            ),
                            SizedBox(height: 20), // المسافة بين الشعار والزر

                            // رسالة عدم وجود اتصال بالإنترنت
                            Text(
                              'الرجاء تسجيل الدخول اولاً',
                              style: TextStyle(
                                fontSize: 18, // حجم الخط
                                color: Colors.white, // لون النص
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Refresh(
                      message: state.message,
                      onRefresh: () => context.read<SpokenProverbBloc>().add(
                            SpokenProverbFetchEvent(
                                categoryId: widget
                                    .spokenCategory.spokenProverbsCategoryId),
                          ),
                    );
                  }
                  if (state is SpokenProverbLoading) {
                    return Loader();
                  }
                  if (state is SpokenProverbLoaded) {
                    return SpokenProverbsList(
                      spokenProverbs: state.spokenProverbs,
                    );
                  }
                  return Container();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
