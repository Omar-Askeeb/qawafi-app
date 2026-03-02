import 'package:flutter/material.dart';
import 'package:qawafi_app/core/utils/check_access_level.dart';
import 'package:qawafi_app/core/utils/string_from_duration.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/size_config.dart';
import '../../../audio_player/presentation/pages/audio_player_page.dart';

class PoemList extends StatefulWidget {
  const PoemList(
      {super.key, required this.poemDataModel, this.scrollController});
  final PoemDataModel poemDataModel;
  final ScrollController? scrollController;

  @override
  State<PoemList> createState() => _PoemListState();
}

class _PoemListState extends State<PoemList> {
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
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: widget.poemDataModel.poems.isEmpty
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
                        "لا يوجد أي قصائد في التصنيفات المختارة",
                      )
                    ],
                  ),
                )
              : PoemListView(
                  poemDataModel: widget.poemDataModel,
                  scrollController: widget.scrollController,
                ),
        ),
      ],
    );
  }
}

class PoemListView extends StatefulWidget {
  const PoemListView(
      {super.key,
      required this.poemDataModel,
      this.scrollController,
      this.isShrinkWrap = false});
  final PoemDataModel poemDataModel;
  final ScrollController? scrollController;
  final bool isShrinkWrap;

  @override
  State<PoemListView> createState() => _PoemListViewState();
}

class _PoemListViewState extends State<PoemListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: widget.isShrinkWrap,
      physics:
          widget.isShrinkWrap ? const NeverScrollableScrollPhysics() : null,
      controller: widget.scrollController ?? ScrollController(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: widget.poemDataModel.poems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            checkAccessLevel(
              isFree: widget.poemDataModel.poems[index].isFree,
              context: context,
              function: () => navigatorKey.currentState!.push(
                AudioPlayerScreen.route(
                  widget.poemDataModel.poems[index],
                ),
              ),
            );
            // if (widget.poemDataModel.poems[index].isFree ||
            //     (context.read<AppUserCubit>().state
            //             is AppUserLoggedIn &&
            //         (context.read<AppUserCubit>().state
            //                     as AppUserLoggedIn)
            //                 .user
            //                 .customerType ==
            //             'Subscriber')) {
            // navigatorKey.currentState!.push(
            //   AudioPlayerScreen.route(
            //     widget.poemDataModel.poems[index],
            //   ),
            // );
            //   // Navigator.push(
            //   //   context,
            //   //   AudioPlayerScreen.route(
            //   //     widget.poemDataModel.poems[index],
            //   //   ),
            //   // );
            //   return;
            // }
            // showSnackBar(context,
            //     "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستماع لهذه القصيدة");
            // if ((context.read<AppUserCubit>().state
            //     is AppUserLoggedIn)) {
            //   navigatorKey.currentState!
            //       .push(SubscriptionManagementPage.route());
            // }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: getProportionateScreenWidth(345),
            height: getProportionateScreenHeight(60),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A).withOpacity(0.4),
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
                      //     widget.poemDataModel.poems[index].fileSrc);
                      // _audioPlayer.play();
                    },
                    child: Image.asset(
                      AppImages.ICON_PLAY,
                    ),
                  ),
                  title: Text(
                    '${widget.poemDataModel.poems[index].title} - ${widget.poemDataModel.poems[index].beginning}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppPallete.secondaryColor),
                  ),
                  trailing: Text(
                    formatDuration(widget.poemDataModel.poems[index].duration),
                    style: TextStyle(
                        color: AppPallete.secondaryColor.withOpacity(0.6)),
                  ),
                ),
                if (widget.poemDataModel.poems[index].isFree) ...{
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      decoration: BoxDecoration(
                          color: AppPallete.secondaryColor.withOpacity(0.9),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          )),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Center(
                          child: Text(
                            'مجاني',
                            style: TextStyle(
                                color: AppPallete.blackColor.withOpacity(0.8),
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
    );
  }
}
