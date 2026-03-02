import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/most_streamed_and_newest/bloc/most_streamed_and_newest_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/pages/purpose_melody_choose.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/check_access_level.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../audio_player/presentation/pages/audio_player_page.dart';
import '../widgets/poem_box.dart';
import '../widgets/search_bar.dart';
import 'search_page.dart';

class AllPoemPage extends StatefulWidget {
  static const String routeName = 'AllPoem';
  static route() => MaterialPageRoute(
        builder: (context) => const AllPoemPage(),
        settings: const RouteSettings(name: routeName),
      );

  const AllPoemPage({super.key});

  @override
  State<AllPoemPage> createState() => _AllPoemPageState();
}

class _AllPoemPageState extends State<AllPoemPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MostStreamedAndNewestBloc>().add(FetchMostStreamedAndNewest());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'القصائد'),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      routeSettings: const RouteSettings(name: '/Search'),

                      context: context,
                      isScrollControlled:
                          true, // This makes the modal full-screen
                      builder: (BuildContext context) {
                        return SearchPage();
                      },
                    );
                  },
                  child: AppSearchBar(),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.push(context, PurposeMelodyChoose.route()),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 168,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.allPoems,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppPallete.blackColor.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              // decoration: BoxDecoration(
                              //   color: AppPallete.blackColor.withOpacity(0.45),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              child: const Text(
                                "كل القصائد",
                                style: TextStyle(fontSize: 22),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                // PoemSearchResult(_query),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الأكثر إستماعاً',
                    style: AppTextStyle.poemTextStyle,
                  ),
                ),

                BlocConsumer<MostStreamedAndNewestBloc,
                    MostStreamedAndNewestState>(listener: (context, state) {
                  // TODO: implement listener
                  if (state is MostStreamedAndNewestFailure) {
                    showSnackBar(context, state.message);
                  }
                }, builder: (context, state) {
                  if (state is MostStreamedAndNewestLoading) {
                    return const Loader();
                  }
                  if (state is MostStreamedAndNewestSuccess) {
                    return Column(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(90),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.mostStreamed.poems.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  checkAccessLevel(
                                    isFree:
                                        state.mostStreamed.poems[index].isFree,
                                    context: context,
                                    function: () =>
                                        navigatorKey.currentState!.push(
                                      AudioPlayerScreen.route(
                                        state.mostStreamed.poems[index],
                                      ),
                                    ),
                                  );
                                  // if (state.mostStreamed.poems[index].isFree ||
                                  //     (context.read<AppUserCubit>().state
                                  //             is AppUserLoggedIn &&
                                  //         (context.read<AppUserCubit>().state
                                  //                     as AppUserLoggedIn)
                                  //                 .user
                                  //                 .customerType ==
                                  //             'Subscriber')) {
                                  //   navigatorKey.currentState!.push(
                                  //     AudioPlayerScreen.route(
                                  //       state.mostStreamed.poems[index],
                                  //     ),
                                  //   );

                                  //   return;
                                  // }

                                  // showSnackBar(context,
                                  //     "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستماع لهذه القصيدة");
                                },
                                child: PoemBoxWidget(
                                  poem: state.mostStreamed.poems[index],
                                ),
                              );
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Text(
                        //     'المزيد',
                        //     style: TextStyle(fontSize: 10),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'جديد',
                            style: AppTextStyle.poemTextStyle,
                          ),
                        ),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: [
                        //       PoemBoxWidget(),
                        //       const SizedBox(
                        //         width: 23,
                        //       ),
                        //       PoemBoxWidget(),
                        //       const SizedBox(
                        //         width: 23,
                        //       ),
                        //       PoemBoxWidget(),
                        //       const SizedBox(
                        //         width: 23,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          height: getProportionateScreenHeight(90),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            // shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.newest.poems.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  checkAccessLevel(
                                    isFree: state.newest.poems[index].isFree,
                                    context: context,
                                    function: () =>
                                        navigatorKey.currentState!.push(
                                      AudioPlayerScreen.route(
                                        state.newest.poems[index],
                                      ),
                                    ),
                                  );
                                  // if (state.newest.poems[index].isFree ||
                                  //     (context.read<AppUserCubit>().state
                                  //             is AppUserLoggedIn &&
                                  //         (context.read<AppUserCubit>().state
                                  //                     as AppUserLoggedIn)
                                  //                 .user
                                  //                 .customerType ==
                                  //             'Subscriber')) {
                                  //   Navigator.push(
                                  //     context,
                                  //     AudioPlayerScreen.route(
                                  //       state.newest.poems[index],
                                  //     ),
                                  //   );
                                  // } else {
                                  //   showSnackBar(context,
                                  //       "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستماع لهذه القصيدة");
                                  // }
                                },
                                child: PoemBoxWidget(
                                  poem: state.newest.poems[index],
                                ),
                              );
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        // Align(
                        //   alignment: Alignment.bottomLeft,
                        //   child: Text(
                        //     'المزيد',
                        //     style: TextStyle(fontSize: 10),
                        //   ),
                        // )
                      ],
                    );
                  }
                  return Container();
                }),
                // const SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       PoemBoxWidget(),
                //       const SizedBox(
                //         width: 23,
                //       ),
                //       const SizedBox(
                //         width: 23,
                //       ),
                //       PoemBoxWidget(),
                //       const SizedBox(
                //         width: 23,
                //       ),
                //       PoemBoxWidget(),
                //       const SizedBox(
                //         width: 23,
                //       ),
                //       PoemBoxWidget(),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 6,
                // ),
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: Text(
                //     'المزيد',
                //     style: TextStyle(fontSize: 10),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
