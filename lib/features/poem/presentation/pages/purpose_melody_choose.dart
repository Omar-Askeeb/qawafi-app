import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/poem/presentation/pages/poem_melody_page.dart';
import 'package:qawafi_app/features/purpose/presentation/pages/purpose_page.dart';

import '../../../../core/constants/app_images.dart';
import '../../../melody/presentation/pages/melody_page.dart';
import '../widgets/image_label_stack.dart';
import '../widgets/search_bar.dart';
import 'search_page.dart';

class PurposeMelodyChoose extends StatelessWidget {
  static const String routeName = 'PurposeMelodyChoose';
  static route() => MaterialPageRoute(
        builder: (context) => const PurposeMelodyChoose(),
        settings: const RouteSettings(name: routeName),
      );

  const PurposeMelodyChoose({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const QawafiAppBar(title: 'القصائد'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    routeSettings: const RouteSettings(name: '/Search'),
                    isScrollControlled:
                        true, // This makes the modal full-screen
                    builder: (BuildContext context) {
                      return const SearchPage();
                    },
                  );
                },
                child: AppSearchBar(),
              ),
              const SizedBox(
                height: 30,
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: GestureDetector(
              //     onTap: () => Navigator.push(context, PurposePage.route()),
              //     child: Container(
              //         height: 168,
              //         width: double.infinity,

              //         child: ImageLabelStack(
              //           text: "الأغــراض",
              //           height: getProportionateScreenHeight(168),
              //           width: getProportionateScreenWidth(
              //               SizeConfig.screenWidth! - 30),
              //           imagePath: AppImages.purpose_melody_choose,
              //         )),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.center,
              //   child: GestureDetector(
              //     onTap: () => Navigator.push(context, PurposePage.route()),
              //     child: Container(
              //       height: 168,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black
              //                 .withOpacity(1), // Shadow color with opacity
              //             spreadRadius: 1, // Spread of the shadow
              //             blurRadius: 8, // Blur intensity
              //             offset: Offset(0, 4), // Shadow position (x, y)
              //           ),
              //         ],
              //       ),
              //       child: ImageLabelStack(
              //         text: "الأغــراض",
              //         height: getProportionateScreenHeight(168),
              //         width: getProportionateScreenWidth(
              //             SizeConfig.screenWidth! - 30),
              //         imagePath: AppImages.purpose_melody_choose,
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, PurposePage.route()),
                  child: Container(
                    height: 168,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.3), // Shadow color with opacity
                          spreadRadius: 1, // Spread of the shadow
                          blurRadius: 8, // Blur intensity
                          offset: Offset(0, 4), // Shadow position (x, y)
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Image widget
                        ImageLabelStack(
                          text: "",
                          height: getProportionateScreenHeight(168),
                          width: getProportionateScreenWidth(
                              SizeConfig.screenWidth! - 30),
                          imagePath: AppImages.purpose_melody_choose,
                        ),
                        // Overlaying shaded container
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 163,
                            width: getProportionateScreenWidth(
                                SizeConfig.screenWidth! - 30),
                            decoration: BoxDecoration(
                              color: AppPallete.blackColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        // Text widget or other content on top of the shade
                        Center(
                          child: Text(
                            "الأغــراض",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MelodyPage.route()),
                    child: Container(
                      height: getProportionateScreenHeight(280),
                      width: getProportionateScreenWidth(163),
                      child: Stack(
                        children: [
                          ImageLabelStack(
                            height: getProportionateScreenHeight(280),
                            width: getProportionateScreenWidth(163),
                            text: '',
                            imagePath: AppImages.has_melody,
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppPallete.blackColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              // decoration: BoxDecoration(
                              //   color: AppPallete.blackColor.withOpacity(0.55),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              child: const Text(
                                "مـلـــحــون",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context, PoemMelodyPage.route(melody: null)),
                    child: Container(
                      height: getProportionateScreenHeight(280),
                      width: getProportionateScreenWidth(163),
                      child: Stack(
                        children: [
                          ImageLabelStack(
                            height: getProportionateScreenHeight(280),
                            width: getProportionateScreenWidth(163),
                            text: '',
                            imagePath: AppImages.recitation2,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              // decoration: BoxDecoration(
                              //   color: AppPallete.blackColor.withOpacity(0.55),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              child: const Text(
                                "إلـقـــــــــاء",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppPallete.blackColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
