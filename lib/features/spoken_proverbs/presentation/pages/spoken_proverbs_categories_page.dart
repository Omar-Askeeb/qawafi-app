import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/features/spoken_proverbs/presentation/bloc/spoken_proverb_category_bloc/spoken_proverb_category_bloc.dart';
import 'package:qawafi_app/features/spoken_proverbs/presentation/pages/spoken_proverbs_page.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/theme/app_pallete.dart';

class SpokenProverbsCategoriesPage extends StatefulWidget {
  const SpokenProverbsCategoriesPage({super.key});

  static const String routeName = 'SpokenProverbsCategories';

  static route() => MaterialPageRoute(
        builder: (context) => const SpokenProverbsCategoriesPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SpokenProverbsCategoriesPage> createState() =>
      _SpokenProverbsCategoriesPageState();
}

class _SpokenProverbsCategoriesPageState
    extends State<SpokenProverbsCategoriesPage> {
  @override
  void initState() {
    context
        .read<SpokenProverbCategoryBloc>()
        .add(SpokenProverbCategoryFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'الأمثال المحكية'),
        body: Column(children: [
          BlocConsumer<SpokenProverbCategoryBloc, SpokenProverbCategoryState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is SpokenProverbCategoryLoading) {
                return const Loader(
                  color: AppPallete.whiteColor,
                );
              }
              if (state is SpokenProverbCategoryFailure) {
                if (context.read<AppUserCubit>().state is! AppUserLoggedIn) {
                  return Container(
                    width: double.infinity,
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
                  onRefresh: () =>
                      context.read<SpokenProverbCategoryBloc>().add(
                            SpokenProverbCategoryFetchEvent(),
                          ),
                );
              }
              if (state is SpokenProverbCategoryLoaded) {
                if (state.categories.isEmpty) {
                  return Expanded(
                    child: SizedBox(
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
                            height: 10,
                          ),
                          const Text(
                            "لا يوجد بيانات",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              AppPallete.secondaryColor.withOpacity(.26),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              SpokenProverbPage.route(
                                  spokenCategory: state.categories[index]));
                        },
                        child: Text(
                          state.categories[index].title,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ]),
      ),
    );
  }
}
