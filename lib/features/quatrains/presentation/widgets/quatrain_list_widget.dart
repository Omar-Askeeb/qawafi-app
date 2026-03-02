import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/utils/string_from_duration.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../quatrain_audio_player/presentation/pages/audio_player_page.dart';
import '../../../subscription/presentation/pages/subscription_management_page.dart';

class QuatrainList extends StatefulWidget {
  const QuatrainList(
      {super.key, required this.quatrains, this.scrollController});
  final List<QuatrainModel> quatrains;
  final ScrollController? scrollController;

  @override
  State<QuatrainList> createState() => _QuatrainListState();
}

class _QuatrainListState extends State<QuatrainList> {
  // final AudioPlayer _audioPlayer = AudioPlayer();

  // Future<void> _setUpAudio(String url) async {
  //   try {
  //     // Initialize the audio source
  //     await _audioPlayer.setUrl(url, headers: {'Range': 'bytes=0-'});
  //   } catch (e) {
  //     print("Error setting up audio source: $e");
  //   }
  // }

  @override
  void dispose() {
    // _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: widget.quatrains.isEmpty
                ? SizedBox(
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
                          height: 30,
                        ),
                        const Text(
                          "لا يوجد أي رباعيات في التصنيفات المختارة",
                        )
                      ],
                    ),
                  )
                : ListView.separated(
                    controller: widget.scrollController ?? ScrollController(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: widget.quatrains.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.quatrains[index].isFree ||
                              (context.read<AppUserCubit>().state
                                      is AppUserLoggedIn &&
                                  (context.read<AppUserCubit>().state
                                              as AppUserLoggedIn)
                                          .user
                                          .customerType ==
                                      'Subscriber')) {
                            Navigator.push(
                              context,
                              QuatrainAudioPlayerScreen.route(
                                widget.quatrains[index],
                              ),
                            );
                          } else {
                            showSnackBar(context,
                                "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستماع لهذه الرباعية");
                            if ((context.read<AppUserCubit>().state
                                is AppUserLoggedIn)) {
                              navigatorKey.currentState!
                                  .push(SubscriptionManagementPage.route());
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          width: getProportionateScreenWidth(345),
                          height: getProportionateScreenHeight(60),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3A3A).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Stack(
                            children: [
                              ListTile(
                                leading: GestureDetector(
                                  onTap: () async {
                                    // await _setUpAudio(
                                    //     widget.quatrains[index].fileSrc);
                                    // _audioPlayer.play();
                                  },
                                  child: Image.asset(
                                    AppImages.ICON_PLAY,
                                  ),
                                ),
                                title: Text(
                                  widget.quatrains[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: AppPallete.secondaryColor),
                                ),
                                trailing: Text(
                                  formatDuration(
                                      widget.quatrains[index].duration),
                                  style: TextStyle(
                                      color: AppPallete.secondaryColor
                                          .withOpacity(0.6)),
                                ),
                              ),
                              if (widget.quatrains[index].isFree) ...{
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: AppPallete.secondaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        )),
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Center(
                                        child: Text(
                                          'مجاني',
                                          style: TextStyle(
                                              color: AppPallete.blackColor
                                                  .withOpacity(0.8),
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              },
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
