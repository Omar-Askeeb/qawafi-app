import 'package:flutter/material.dart';
import 'package:qawafi_app/core/utils/check_access_level.dart';
import 'package:qawafi_app/core/utils/string_from_duration.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_model.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/theme/app_pallete.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../spoken_proverbs_audio_player/presentation/pages/audio_player_page.dart';

class SpokenProverbsList extends StatefulWidget {
  const SpokenProverbsList(
      {super.key, required this.spokenProverbs, this.scrollController});
  final List<SpokenProverbModel> spokenProverbs;
  final ScrollController? scrollController;

  @override
  State<SpokenProverbsList> createState() => _SpokenProverbsListState();
}

class _SpokenProverbsListState extends State<SpokenProverbsList> {
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
          child: widget.spokenProverbs.isEmpty
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
                        "لا يوجد امثال في التصنيف المختار",
                      )
                    ],
                  ),
                )
              : ListView.separated(
                  controller: widget.scrollController ?? ScrollController(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: widget.spokenProverbs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        checkAccessLevel(
                          context: context,
                          function: () => Navigator.push(
                            context,
                            SpokenProverbsAudioPlayerScreen.route(
                              widget.spokenProverbs[index],
                            ),
                          ),
                          isFree: widget.spokenProverbs[index].isFree,
                        );
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
                                widget.spokenProverbs[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppPallete.secondaryColor),
                              ),
                              trailing: Text(
                                formatDuration(
                                    widget.spokenProverbs[index].duration),
                                style: TextStyle(
                                    color: AppPallete.secondaryColor
                                        .withOpacity(0.6)),
                              ),
                            ),
                            if (widget.spokenProverbs[index].isFree) ...{
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
    );
  }
}
