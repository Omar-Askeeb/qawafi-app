import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/app_button.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/utils/SizeConfigPercentage.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/competition/presentation/pages/competition_list_page.dart';
import 'package:qawafi_app/features/crpt/presentation/pages/AlphabetPageCrpt.dart';
import 'package:qawafi_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/widgets/poem_list_widget.dart';
import 'package:qawafi_app/features/poet/presentation/pages/poet_page.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/check_access_level.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/rings_dialog.dart';
import '../../../ads/presentation/bloc/advertisement_bloc.dart';
import '../../../ads/presentation/pages/ads_page.dart';
import '../../../libyan_titles/presentation/pages/libyan_titles_page.dart';
import '../../../poem/presentation/pages/all_poem_page.dart';
import '../../../poet/presentation/pages/poet_profile_page.dart';
import '../../../popularProverbs/presentation/pages/AlphabetPage.dart';
import '../../../quatrains_category/presentation/pages/quatrain_category_page.dart';
import '../../../spoken_proverbs/presentation/pages/spoken_proverbs_categories_page.dart';
import '../../../storyProverb/presentation/pages/storyProverbPage.dart';
import '../../../wordsMeaning/presentation/pages/wordsMeaning.dart';
import '../widgets/categories_container.dart';
import '../widgets/categories_container_CRPT.dart';
import 'sections_page.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  static const String routeName = '/HomeV2';

  static route() => MaterialPageRoute(
        builder: (context) => const HomePageV2(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _items =
      List<String>.generate(50, (index) => "Item $index");
  bool _isAutoScrolling = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeFetchDataEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

//   bool isForward = true;
//   void _autoScroll() async {
//     while (_isAutoScrolling) {
//       await Future.delayed(Duration(seconds: 2)); // Delay between scrolls

//       if (!_scrollController.hasClients) {
//         // Ensure the ScrollController is attached to the ListView
//         continue;
//       }
// log(isForward.toString());
//       if (_scrollController.position.pixels ==
//               _scrollController.position.maxScrollExtent &&
//           !isForward) {
//         // If reached the end, scroll back to the top
//         _scrollController.animateTo(
//           _scrollController.position.pixels -
//               SizeConfigPercentage.safeBlockHorizontal! * 50,
//           duration: Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//         if (_scrollController.position.pixels == 0) {
//           isForward = false;
//         }
//       } else {
//         // Scroll down by a fixed amount
//         _scrollController.animateTo(
//           _scrollController.position.pixels +
//               SizeConfigPercentage.safeBlockHorizontal! * 50,
//           duration: Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//         if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent) {
//           isForward = false;
//         }
//       }
//     }
//   }
  bool _isForward = true;

  void _autoScroll() async {
    while (_isAutoScrolling) {
      await Future.delayed(Duration(seconds: 2)); // Delay between scrolls

      if (!_scrollController.hasClients) {
        // Ensure the ScrollController is attached to the ListView
        continue;
      }

      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentPosition = _scrollController.position.pixels;

      if (_isForward) {
        // Scroll forward by 50 pixels
        double nextPosition =
            currentPosition + SizeConfigPercentage.safeBlockHorizontal! * 50;

        if (nextPosition >= maxScrollExtent) {
          // If reached the end, change direction to backward
          nextPosition = maxScrollExtent;
          _isForward = false;
        }

        _scrollController.animateTo(
          nextPosition,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        // Scroll backward by 50 pixels
        double nextPosition =
            currentPosition - SizeConfigPercentage.safeBlockHorizontal! * 50;

        if (nextPosition <= 0) {
          // If reached the start, change direction to forward
          nextPosition = 0;
          _isForward = true;
        }

        _scrollController.animateTo(
          nextPosition,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
            title: context.read<AppUserCubit>().state is AppUserInitial
                ? 'زائر'
                : (context.read<AppUserCubit>().state as AppUserLoggedIn)
                    .user
                    .name),
        body: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Cairo'),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<AdvertisementBloc>().add(AdvertisementFetch());
              context.read<HomeBloc>().add(HomeFetchDataEvent());
            },
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
                            fontWeight: FontWeight.w500,
                            color: AppPallete.whiteColor.withOpacity(1)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(188),
                    width: double.infinity,
                    child: const AdsPage(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        const CompetitionContainer(),
                        const SizedBox(
                          height: 20,
                        ),
                        const PoemContainer(),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'الأقسام',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context, SectionsPage.route()),
                                  child: const Text(
                                    'عرض الكل',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppPallete.secondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Sections(scrollController: _scrollController),
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<HomeBloc, HomeState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if (state is HomeFailure) {
                              showSnackBar(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is HomeLoaded) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'اهم الشعراء',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppPallete.whiteColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context, PoetPage.route()),
                                        child: const Text(
                                          'عرض الكل',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppPallete.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 120,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.poets.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              width: 15,
                                            ),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                // onTap: () => context
                                                // .read<PoetBloc>()
                                                // .add(PoetGoToDetails(poetId: poets[index].poetId)),
                                                onTap: () => Navigator.push(
                                                    context,
                                                    PoetProfilePage.route(state
                                                        .poets[index].poetId)),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 90,
                                                      width: 90,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(90),
                                                        child: Image.network(
                                                          state.poets[index]
                                                              .imageSrc,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.poets[index]
                                                          .fullName,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        flex: 1,
                                        child: Text(
                                          'مقترحة لك',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppPallete.whiteColor,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Center(
                                          child: Container(
                                            height: 30,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFA06F26),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        22.5)),
                                            child: const Center(
                                              child: Text(
                                                'رائج الان',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppPallete.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(flex: 1, child: Container()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  PoemListView(
                                    poemDataModel: state.poems,
                                    isShrinkWrap: true,
                                  )
                                ],
                              );
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Sections extends StatelessWidget {
  const Sections({
    super.key,
    required this.scrollController,
  });
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(170),
      child: ListView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          children: <Widget>[
            CategoyContainer(
              imagePath: AppImages.POUOLAURE_SAYINGS,
              text: 'أمثال شعبية',
              onPressed: () => Navigator.push(context, AlphabetPage.route()),
            ),
            const SizedBox(
              width: 20,
            ),
            CategoyContainer(
              imagePath: AppImages.Quatrain,
              text: "رباعيات",
              onPressed: () =>
                  Navigator.push(context, QuatrainCategoryPage.route()),
            ),
            const SizedBox(
              width: 20,
            ),
            CategoyContainer(
              imagePath: AppImages.SpokenPeoverb,
              text: 'حكاية مثل',
              onPressed: () =>
                  navigatorKey.currentState!.push(StoryProverbPage.route()),
            ),
            const SizedBox(
              width: 20,
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
            const SizedBox(
              width: 20,
            ),
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
            const SizedBox(
              width: 20,
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
          ]),
    );
  }
}

class CompetitionContainer extends StatelessWidget {
  const CompetitionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 140,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Competition background image
            Image.asset(
              AppImages.competitionBackground,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            // Text and button overlay
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 15,
                  left: 20,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        "مسابقة قوافي الشعرية",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Reem',
                          fontSize: 22,
                          color: AppPallete.whiteColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120,
                        child: AppButton(
                          text: "صوت الان",
                          fontFamily: 'Cairo',
                          borderColor: Colors.transparent,
                          color: const Color(0xFFF5F5DC), // Light beige/off-white
                          textColor: Colors.black,
                          opicity: 1.0,
                          height: 40,
                          onPressed: () {
                            Navigator.push(context, CompetitionListPage.route());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PoemContainer extends StatelessWidget {
  const PoemContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            AppImages.poemHomeBtnBackground,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 20,
            bottom: 10, // اضف هامشًا إلى الأسفل للزر
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    "القصائد",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Reem', fontSize: 22),
                  ),
                ),
                const Text(
                  "استمتع بتجربة حصرية مع مجموعة متنوعة من القصائد الملهمة والشعر الراقي في مختلف المجالات.",
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 13),
                ),
                Spacer(), // يملأ المساحة المتبقية بين النص والزر

                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                    text: "أبدأ التجربة الأن",
                    fontFamily: 'Cairo',
                    borderColor: AppPallete.whiteColor.withOpacity(0.3),
                    color: Color.fromARGB(255, 0, 0, 0),
                    textColor: AppPallete.whiteColor,
                    onPressed: () => Navigator.push(
                      context,
                      AllPoemPage.route(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
