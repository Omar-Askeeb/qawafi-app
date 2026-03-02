import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/ads/data/models/advertisement_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_pallete.dart';
import '../bloc/advertisement_bloc.dart';

class Ad {
  final String imageUrl;
  final String title;
  final String description;

  Ad({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  void initState() {
    context.read<AdvertisementBloc>().add(AdvertisementFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<AdvertisementModel> advertisements = [Ad];
    // final List<AdvertisementModel> ads = [
    //   AdvertisementModel(
    //     imageSrc: AppImages.AD_1,
    //     advertisementId: '',
    //     isDisabled: false,
    //     url: '',
    //     title: 'Placeholder 1',
    //     description: 'Description for Ad 1',
    //   ),
    //   AdvertisementModel(
    //     imageSrc: AppImages.AD_2,
    //     advertisementId: '',
    //     isDisabled: false,
    //     url: '',
    //     title: 'Placeholder 2',
    //     description: 'Description for Ad 2',
    //   ),
    //   AdvertisementModel(
    //     imageSrc: AppImages.AD_3,
    //     advertisementId: '',
    //     isDisabled: false,
    //     url: '',
    //     title: 'Placeholder 3',
    //     description: 'Description for Ad 3',
    //   ),
    //   // AdvertisementModel(
    //   //   imageUrl: AppImages.AD_3,
    //   //   title: 'Ad 2',
    //   //   description: 'Description for Ad 2',
    //   // ),
    //   // AdvertisementModel(
    //   //   imageUrl: AppImages.AD_3,
    //   //   title: 'Ad 3',
    //   //   description: 'Description for Ad 3',
    //   // ),
    // ];

    return BlocConsumer<AdvertisementBloc, AdvertisementState>(
      listener: (context, state) {
        if (state is AdvertisementFailure) {
          showSnackBar(
              context, 'لم يتم تحميل الإعلانات قم بسحب الشاشة للتحديث');
        }
      },
      builder: (context, state) {
        if (state is AdvertisementFailure) {
          return Refresh(
              message: state.message,
              height: 50,
              onRefresh: () =>
                  context.read<AdvertisementBloc>().add(AdvertisementFetch()));
        }
        if (state is AdvertisementLoading) {
          return const Loader();
        }
        if (state is AdvertisementSuccess) {
          return CustomCarouselSlider(
            ads: state.ads,
          );
        }
        return Container();
        // return CarouselSlider(
        //   items: ads.map((ad) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //           width: getProportionateScreenWidth(301),
        //           height: getProportionateScreenHeight(188),
        //           child: Image.asset(
        //             ad.imageUrl,
        //           ),
        //         );
        //       },
        //     );
        //   }).toList(),
        //   options: CarouselOptions(
        //     // width: getProportionateScreenWidth(301),
        //     // height: getProportionateScreenHeight(188),
        //     // aspectRatio: 16 / 9,
        //     viewportFraction: 0.8,
        //     enlargeCenterPage: true,
        //     scrollDirection: Axis.horizontal,
        //     autoPlay: true,

        //     autoPlayInterval: Duration(seconds: 3),
        //     onPageChanged: (index, reason) {},
        //   ),
        // );
      },
    );
  }
}

class CustomCarouselSlider extends StatelessWidget {
  final List<AdvertisementModel>? ads;

  CustomCarouselSlider({this.ads});

  void _launchURL(String url) async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return ads == null || ads!.isEmpty
        ? Container(
            width: double.infinity,
            height: 200.0,
            color: Colors.grey,
            child: Center(
              child: Text(
                'No ads available',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          )
        : CarouselSlider(
            items: ads!.map((ad) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      log(ad.url);
                      if (ad.url.isNotEmpty) {
                        _launchURL(ad.url);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8), 
                      width: getProportionateScreenWidth(301),
                      height: getProportionateScreenHeight(188),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ad.advertisementId.isEmpty
                            ? Image.asset(
                                ad.imageSrc,
                                fit: BoxFit.cover,
                                width: getProportionateScreenWidth(301),
                                height: getProportionateScreenHeight(188),
                              )
                            : Image.network(
                                ad.imageSrc,
                                fit: BoxFit.cover,
                                width: getProportionateScreenWidth(301),
                                height: getProportionateScreenHeight(188),
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  child: Center(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(AppImages.LOGO)),
                                  ),
                                ),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    // The image has loaded
                                    return child;
                                  } else {
                                    // The image is still loading
                                    return Container(
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                    AppImages.LOGO)),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Loader(
                                                color: AppPallete.whiteColor
                                                    .withOpacity(0.5)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              // width: getProportionateScreenWidth(301),
              // height: getProportionateScreenHeight(188),
              // aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              padEnds: true,
              autoPlayInterval: Duration(seconds: 3),
              onPageChanged: (index, reason) {},
            ),
          );
    // : CarouselSlider(
    //     items: ads!.map((ad) {
    //       return Builder(
    //         builder: (BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     if (ad.url.isNotEmpty) {
    //       _launchURL(ad.url);
    //     }
    //   },
    //             child: Container(
    //               width: MediaQuery.of(context).size.width * 0.8,
    //               margin: EdgeInsets.symmetric(horizontal: 5.0),
    // child: ad.advertisementId.isEmpty
    //     ? Image.asset(
    //         ad.imageSrc,
    //         fit: BoxFit.cover,
    //       )
    //     : Image.network(
    //         ad.imageSrc,
    //         fit: BoxFit.cover,
    //       ),
    //             ),
    //           );
    //         },
    //       );
    //     }).toList(),
    //     options: CarouselOptions(
    //       viewportFraction: 0.8,
    //       enlargeCenterPage: true,
    //       scrollDirection: Axis.horizontal,
    //       autoPlay: true,
    //       autoPlayInterval: Duration(seconds: 3),
    //       onPageChanged: (index, reason) {},
    //     ),
    //   );
  }
}
