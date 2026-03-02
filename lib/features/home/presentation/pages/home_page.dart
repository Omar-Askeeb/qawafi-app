import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/navigator_key.dart';
import 'package:qawafi_app/features/ads/presentation/bloc/advertisement_bloc.dart';
import 'package:qawafi_app/features/ads/presentation/pages/ads_page.dart';
import 'package:qawafi_app/features/home/presentation/pages/libyan_name.dart';
import 'package:qawafi_app/features/home/presentation/widgets/categories_container.dart';
import 'package:qawafi_app/features/home/presentation/widgets/categories_container_CRPT.dart';
import 'package:qawafi_app/features/poem/presentation/pages/all_poem_page.dart';
import 'package:qawafi_app/features/popularProverbs/presentation/pages/AlphabetPage.dart';
import 'package:qawafi_app/features/quatrains_category/presentation/pages/quatrain_category_page.dart';
import 'package:qawafi_app/features/wordsMeaning/presentation/pages/wordsMeaning.dart';
import 'package:qawafi_app/features/competition/presentation/pages/competition_list_page.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/utils/check_access_level.dart';
import '../../../../core/utils/rings_dialog.dart';
import '../../../../core/utils/size_config.dart';
import '../../../crpt/presentation/pages/AlphabetPageCrpt.dart';
import '../../../libyan_titles/presentation/pages/libyan_titles_page.dart';
import '../../../spoken_proverbs/presentation/pages/spoken_proverbs_categories_page.dart';
import '../../../storyProverb/presentation/pages/storyProverbPage.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/Home';
  const HomePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(SizeConfig.screenWidth);
    print(SizeConfig.screenHeight);
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
            title: context.read<AppUserCubit>().state is AppUserInitial
                ? 'زائر'
                : (context.read<AppUserCubit>().state as AppUserLoggedIn)
                    .user
                    .name),
        body: RefreshIndicator(
          onRefresh: () async =>
              context.read<AdvertisementBloc>().add(AdvertisementFetch()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'لوحة الإعلانات',
                      style: TextStyle(
                          fontSize: 18,
                          color: AppPallete.whiteColor.withOpacity(0.6)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const AdsPage(),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'الأقسام',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppPallete.whiteColor.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoyContainer(
                        imagePath: AppImages.POUOLAURE_SAYINGS,
                        text: 'أمثال شعبية',
                        onPressed: () =>
                            Navigator.push(context, AlphabetPage.route()),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      CategoyContainer(
                        imagePath: AppImages.Quatrain,
                        text: "رباعيات",
                        onPressed: () => Navigator.push(
                            context, QuatrainCategoryPage.route()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CategoyContainer(
                  imagePath: AppImages.poem,
                  text: "قصائد",
                  width: getProportionateScreenWidth(168) * 2 + 10,
                  onPressed: () => Navigator.push(
                    context,
                    AllPoemPage.route(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoyContainer(
                          imagePath: AppImages.SpokenPeoverb,
                          text: 'حكاية مثل',
                          onPressed: () => navigatorKey.currentState!
                              .push(StoryProverbPage.route()),
                        ),
                        CategoyContainer(
                          imagePath: AppImages.SpokenPeoverbs,
                          text: "أمثال محكية",
                          onPressed: () => checkAccessLevel(
                            context: context,
                            function: () => Navigator.push(
                              context,
                              SpokenProverbsCategoriesPage.route(),
                            ),
                            isFree: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CategoyContainerCRPT(
                  imagePath: AppImages.CRPT,
                  text: "رنات إنتظار",
                  width: getProportionateScreenWidth(168) * 2 + 10,
                  onPressed: () {
                    ringsDialog(context: context);
                    Navigator.push(context, AlphabetCrptPage.route());
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoyContainer(
                          imagePath: AppImages.WordMeaningDictionary,
                          text: 'قاموس\nالكلمات الشعبية',
                          onPressed: () => checkAccessLevel(
                            context: context,
                            function: () => Navigator.push(
                              context,
                              WordsMeaningPage.route(),
                            ),
                            isFree: false,
                          ),
                        ),
                        CategoyContainer(
                          imagePath: AppImages.LibyanNames,
                          text: "مسميات ليبية",
                          onPressed: () => checkAccessLevel(
                            context: context,
                            function: () => Navigator.push(
                              context,
                              LibyanTitlesPage.route(),
                            ),
                            isFree: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CategoyContainer(
                  imagePath: AppImages.competitionBackground,
                  text: "صوت الان",
                  width: getProportionateScreenWidth(168) * 2 + 10,
                  onPressed: () => Navigator.push(
                    context,
                    CompetitionListPage.route(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
                //   child: Container(
                // margin: const EdgeInsets.symmetric(
                //   horizontal: 10,
                // ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Align(
                //           alignment: Alignment.topRight,
                //           child: Text(
                //             'الأقسام',
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: AppPallete.whiteColor.withOpacity(
                //                 0.6,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CategoyContainer(
                //               imagePath: AppImages.POUOLAURE_SAYINGS,
                //               text: 'أمثال شعبية',
                //               onPressed: () =>
                //                   Navigator.push(context, AlphabetPage.route()),
                //             ),
                //             // const SizedBox(
                //             //   width: 10,
                //             // ),
                //             CategoyContainer(
                //               imagePath: AppImages.poit2,
                //               text: "رباعيات",
                //               onPressed: () => Navigator.push(
                //                   context, QuatrainCategoryPage.route()),
                //             ),
                //           ],
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         CategoyContainer(
                //           imagePath: AppImages.poit,
                //           text: "قصائد",
                //           width: getProportionateScreenWidth(168) * 2 + 10,
                //           onPressed: () =>
                //               Navigator.push(context, AllPoemPage.route()),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(top: 10),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               CategoyContainer(
                //                 imagePath: AppImages.poit3,
                //                 text: 'حكاية مثل',
                //                 onPressed: () => Navigator.push(
                //                     context, StoryProverbPage.route()),
                //               ),
                //               CategoyContainer(
                //                 imagePath: AppImages.poit4,
                //                 text: "أمثال محكية",
                //                 onPressed: () => Navigator.push(
                //                     context, WordsMeaningPage.route()),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              
            ),
          ),
        ),
      ),
    );
  }
}
