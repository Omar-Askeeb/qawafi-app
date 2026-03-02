import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/utils/SizeConfigPercentage.dart';
import 'package:qawafi_app/features/quatrains/presentation/pages/quatrains_page.dart';
import 'package:qawafi_app/features/quatrains_category/data/models/quatrains_category_model.dart';

import '../../../../core/theme/app_pallete.dart';

class DynamicHeightGridView extends StatelessWidget {
  final List<QuatrainsCategoryModel> imageUrls;

  DynamicHeightGridView({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2, // Two columns
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          QuatrainsPage.route(
            imageUrls[index],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: SizeConfigPercentage.safeBlockHorizontal! * 40,
          height: 180,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  imageUrls[index].imageSrc,
                  fit: BoxFit.fitHeight,
                  // fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppImages.LOGO)),

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      // The image has loaded
                      return child;
                    } else {
                      // The image is still loading
                      return Container(
                        child: Center(
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(AppImages.LOGO)),
                              Loader(
                                  color:
                                      AppPallete.whiteColor.withOpacity(0.5)),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 15),
                  height: 60,
                  decoration: BoxDecoration(
                    // color: AppPallete.blackColor.withOpacity(0.5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0.20,
                        0.25,
                        0.27,
                        0.30,
                        0.39,
                        // 0.71,
                        1.0,
                      ],
                      colors: [
                        AppPallete.blackColor.withOpacity(0.09),
                        AppPallete.blackColor.withOpacity(0.12),
                        AppPallete.blackColor.withOpacity(0.2),
                        AppPallete.blackColor.withOpacity(0.4),
                        AppPallete.blackColor.withOpacity(0.51),
                        // AppPallete.blackColor.withOpacity(0.95),
                        AppPallete.blackColor.withOpacity(1.0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  // width: 100,
                  child: Center(
                      child: Text(
                    imageUrls[index].title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        color: AppPallete.secondaryColor, fontSize: 20),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 10.0,
    );
  }
}
