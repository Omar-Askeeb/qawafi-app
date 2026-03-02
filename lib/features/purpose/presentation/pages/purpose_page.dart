import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/purpose/domain/entites/purpose.dart';
import 'package:qawafi_app/features/purpose/presentation/bloc/purpose_bloc.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/SizeConfigPercentage.dart';
import '../../../poem/presentation/pages/poem_page.dart';

class PurposePage extends StatefulWidget {
  const PurposePage({super.key});
  static const String routeName = 'Purpose';
  static route() => MaterialPageRoute(
        builder: (context) => const PurposePage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<PurposePage> createState() => _PurposePageState();
}

class _PurposePageState extends State<PurposePage> {
  @override
  void initState() {
    context.read<PurposeBloc>().add(PurposeFetchAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: "الأغراض"),
        body: SafeArea(
          child: BlocConsumer<PurposeBloc, PurposeState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is PurposeFailure) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is PurposeLoading) {
                return const Loader();
              }
              if (state is PurposeFailure) {
                return GestureDetector(
                  onTap: () {
                    context.read<PurposeBloc>().add(PurposeFetchAll());
                  },
                  child: Container(
                    width: double.infinity,
                    child: const Column(children: [
                      Text('مشكلة في ما حاول مجدداً'),
                      Icon(
                        Icons.refresh,
                      )
                    ]),
                  ),
                );
              }
              if (state is PurposeSuccess) {
                return Column(
                  children: [
                    Expanded(
                      child: DynamicHeightGridView(
                        imageUrls: state.purposes,
                      ),
                    )
                    // StaggeredGrid.count(
                    //   crossAxisCount: 2,
                    //   mainAxisSpacing: 4,
                    //   crossAxisSpacing: 4,
                    //   children: [

                    //     StaggeredGridTile.count(
                    //       crossAxisCellCount: 1,
                    //       mainAxisCellCount: 1.5,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             // color: AppPallete.errorColor,
                    //             borderRadius: BorderRadius.circular(20)),
                    //         child: Image.asset(
                    //           AppImages.religion,
                    //           fit: BoxFit.fitWidth,
                    //         ),
                    //       ),
                    //     ),
                    //     StaggeredGridTile.count(
                    //       crossAxisCellCount: 1,
                    //       mainAxisCellCount: 1,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //             // color: AppPallete.errorColor,
                    //             borderRadius: BorderRadius.circular(20)),
                    //         child: Image.asset(
                    //           AppImages.religion,
                    //           fit: BoxFit.fitWidth,
                    //         ),
                    //       ),
                    //     ),
                    //     StaggeredGridTile.count(
                    //       crossAxisCellCount: 1,
                    //       mainAxisCellCount: 1,
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //       // color: AppPallete.errorColor,
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: Image.asset(
                    //     AppImages.religion,
                    //     fit: BoxFit.fitWidth,
                    //   ),
                    // ),
                    //     ),
                    //   ],
                    // )

                    // Expanded(
                    //   child: GridView.custom(
                    //     gridDelegate: SliverQuiltedGridDelegate(
                    //       crossAxisCount: 4,
                    //       mainAxisSpacing: 4,
                    //       crossAxisSpacing: 4,
                    //       repeatPattern: QuiltedGridRepeatPattern.inverted,
                    //       pattern: [
                    //         const QuiltedGridTile(1, 2),
                    //         const QuiltedGridTile(1, 1),
                    //       ],
                    //     ),
                    //     childrenDelegate: SliverChildBuilderDelegate(
                    //       (context, index) => Container(
                    // child: Image.asset(
                    //   AppImages.religion,
                    //   fit: BoxFit.cover,
                    // ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class DynamicHeightGridView extends StatelessWidget {
  final List<Purpose> imageUrls;

  DynamicHeightGridView({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2, // Two columns
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          PoemPage.route(
            purpose: imageUrls[index],
          ),
        ),
        child: Container(
          width: SizeConfigPercentage.safeBlockHorizontal! * 48,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: SizedBox(
                  width: SizeConfigPercentage.safeBlockHorizontal! * 48,
                  height: 180,
                  child: Image.network(
                    imageUrls[index].imageSrc,
                    fit: BoxFit.fitWidth,
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
                      imageUrls[index].purposeName,
                      style: const TextStyle(
                          color: AppPallete.secondaryColor, fontSize: 20),
                    )),
                  ))
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
