import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/rings_dialog.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/check_access_level.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/size_config.dart';
import '../../../ads/presentation/pages/ads_page.dart';
import '../../../crpt/presentation/pages/AlphabetPageCrpt.dart';
import '../../../libyan_titles/presentation/pages/libyan_titles_page.dart';
import '../../../poem/presentation/pages/all_poem_page.dart';
import '../../../popularProverbs/presentation/pages/AlphabetPage.dart';
import '../../../quatrains_category/presentation/pages/quatrain_category_page.dart';
import '../../../spoken_proverbs/presentation/pages/spoken_proverbs_categories_page.dart';
import '../../../storyProverb/presentation/pages/storyProverbPage.dart';
import '../../../wordsMeaning/presentation/pages/wordsMeaning.dart';
import '../widgets/categories_container.dart';
import '../widgets/categories_container_CRPT.dart';
import 'libyan_name.dart';

class SectionsPage extends StatelessWidget {
  const SectionsPage({super.key});
  static const String routeName = '/Sections';

  static route() => MaterialPageRoute(
        builder: (context) => const SectionsPage(),
        settings: const RouteSettings(name: routeName),
      );
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: QawafiAppBar(title: 'الأقسام'),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    onPressed: () =>
                        Navigator.push(context, QuatrainCategoryPage.route()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
              height: 10,
            ),
            CategoyContainerCRPT(
                imagePath: AppImages.CRPT,
                text: "رنات إنتظار",
                width: getProportionateScreenWidth(168) * 2 + 10,
                onPressed: () {
                  ringsDialog(context: context);
                  Navigator.push(context, AlphabetCrptPage.route());
                }),
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
              imagePath: AppImages.trip,
              text: "رحلات قوافي",
              width: getProportionateScreenWidth(168) * 2 + 10,
              onPressed: () => Navigator.push(
                context,
                LibyanNamePlaceholder.route("رحلات قوافي"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CategoyContainer(
              imagePath: AppImages.party,
              text: "أمسيات قوافي",
              width: getProportionateScreenWidth(168) * 2 + 10,
              onPressed: () => Navigator.push(
                context,
                LibyanNamePlaceholder.route('أمسيات قوافي'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // body: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2, // Number of columns
      //     crossAxisSpacing: 10,
      //     mainAxisSpacing: 10,
      //     childAspectRatio: 1, // Aspect ratio of the items
      //   ),
      //   itemCount: 6, // Number of items
      //   itemBuilder: (context, index) {
      //     return Container(
      //       child: ,

      //     );
      //   },
      // ),
    ));
  }
}
