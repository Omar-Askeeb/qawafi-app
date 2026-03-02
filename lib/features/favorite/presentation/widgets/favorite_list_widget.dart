import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/utils/string_from_duration.dart';
import 'package:qawafi_app/features/poem/data/models/poem_model.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../audio_player/presentation/pages/audio_player_page.dart';
import '../../../quatrain_audio_player/presentation/pages/audio_player_page.dart';
import '../../data/models/favorite_display_model.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    super.key,
    required this.data,
    this.scrollController,
    required this.originalData,
  });
  final List<FavoriteDisplayModel> data;
  final ScrollController? scrollController;
  final dynamic originalData;

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  void dispose() {
    // _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: widget.data.isEmpty
                ? const Text(
                    "أضف للمفضلة لسهولة الوصول",
                  )
                : ListView.separated(
                    controller: widget.scrollController ?? ScrollController(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.data[index].isFree ||
                              (context.read<AppUserCubit>().state
                                      is AppUserLoggedIn &&
                                  (context.read<AppUserCubit>().state
                                              as AppUserLoggedIn)
                                          .user
                                          .customerType ==
                                      'Subscriber')) {
                            _navigation(index);
                            return;
                          }
      
                          showSnackBar(context,
                              "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستماع لهذه القصيدة");
                        },
                        child: Container(
                          width: getProportionateScreenWidth(345),
                          height: getProportionateScreenHeight(60),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3A3A).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                // await _setUpAudio(
                                //     widget.data[index].fileSrc);
                                // _audioPlayer.play();
                              },
                              child: Image.asset(
                                AppImages.ICON_PLAY,
                              ),
                            ),
                            title: Text(
                              '${widget.data[index].title} - ${widget.data[index].subTitle}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AppPallete.secondaryColor),
                            ),
                            trailing: Text(
                              formatDuration(widget.data[index].duration),
                              style: TextStyle(
                                  color:
                                      AppPallete.secondaryColor.withOpacity(0.6)),
                            ),
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

  _navigation(int index) {
    if (widget.originalData is List<PoemModel>) {
      navigatorKey.currentState!.push(
        AudioPlayerScreen.route(
          widget.originalData[index],
        ),
      );
    }
    if (widget.originalData is List<QuatrainModel>) {
      Navigator.push(
        context,
        QuatrainAudioPlayerScreen.route(
          widget.originalData[index],
        ),
      );
    }
  }
}
