import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/string_from_duration.dart';
import 'package:qawafi_app/features/storyProverb/presentation/bloc/favorite/favorite_storyproverb_bloc.dart';
import 'package:qawafi_app/features/storyProverb/presentation/bloc/listProverbStory/list_story_proverb_bloc.dart';
import 'package:qawafi_app/features/storyProverb/presentation/bloc/playerProverbStory/playerStoryProverb_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../subscription/presentation/pages/subscription_management_page.dart';

class StoryProverbPage extends StatefulWidget {
  const StoryProverbPage();

  static const String routeName = '/StoryProverb';
  static route() => MaterialPageRoute(
        builder: (context) => const StoryProverbPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<StoryProverbPage> createState() => _StoryProverbPageState();
}

class _StoryProverbPageState extends State<StoryProverbPage> {
  @override
  void initState() {
    context
        .read<ListStoryProverbBloc>()
        .add(GetStoryProverbsEvent(pageNumber: 1, pageSize: 100));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PlayerStoryProverbBloc>().add(PauseEvent());
        context
            .read<PlayerStoryProverbBloc>()
            .add(UpdateProgressEvent(Duration.zero));
        context.read<PlayerStoryProverbBloc>().add(ResetPositionEvent());
        return true;
      },
      child: ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
          appBar: QawafiAppBar(
            title: 'حكاية مثل',
          ),
          body: Column(
            children: [
              Container(
                child: BlocConsumer<PlayerStoryProverbBloc,
                    PlayerStoryProverbState>(
                  listener: (context, state) {
                    // if (state is PlayerStoryProverbFailure) {
                    //   showSnackBar(context, state.message);
                    // }
                  },
                  builder: (context, state) {
                    if (state is PlayerStoryProverbLoading) {
                      return Container(
                          height: 350, child: Center(child: Loader()));
                    }
                    if (state is PlayerStoryProverbLoaded) {
                      return Container(
                        height: 350,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Stack(
                              children: [
                                // عرض العنوان والصورة الخلفية
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 320,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Image.network(
                                      state.currentStoryProverb.imageSrc,
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                // خلفية شفافة على الصورة
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(30.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 340,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.9),
                                          Colors.black.withOpacity(0.08),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // العنوان
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      state.currentStoryProverb.title,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Color(0xFFEAC578),
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0,
                                            color: Colors.black,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                // زر التشغيل باستخدام Image.asset
                                Positioned(
                                  top: 130,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<PlayerStoryProverbBloc>()
                                            .add(PlayPauseEvent());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                        ),
                                        child: BlocBuilder<
                                            PlayerStoryProverbBloc,
                                            PlayerStoryProverbState>(
                                          builder: (context, state) {
                                            if (state
                                                is PlayerStoryProverbLoaded) {
                                              return state.isPlaying
                                                  ? SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: Icon(
                                                          Icons.pause_outlined,
                                                          color: Color(
                                                              0xFFEAC578)),
                                                    )
                                                  : Image.asset(
                                                      AppImages.ICON_PLAY,
                                                      width: 60,
                                                      height: 60,
                                                    );
                                            }
                                            return Image.asset(
                                              AppImages.ICON_PLAY,
                                              width: 60,
                                              height: 60,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // شريط التقدم وزر المفضلة
                                Positioned(
                                  bottom: 20,
                                  left: 16,
                                  right: 16,
                                  child: Column(
                                    children: [
                                      StreamBuilder<Duration>(
                                        stream: context
                                            .read<PlayerStoryProverbBloc>()
                                            .audioPlayer
                                            .positionStream,
                                        builder: (context, snapshot) {
                                          final position =
                                              snapshot.data ?? Duration.zero;
                                          final duration = context
                                                  .read<
                                                      PlayerStoryProverbBloc>()
                                                  .audioPlayer
                                                  .duration ??
                                              Duration.zero;

                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFEAC578),
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Slider(
                                                      value: position.inSeconds
                                                          .toDouble(),
                                                      max: duration.inSeconds
                                                          .toDouble(),
                                                      onChanged: (value) {
                                                        context
                                                            .read<
                                                                PlayerStoryProverbBloc>()
                                                            .audioPlayer
                                                            .seek(Duration(
                                                                seconds: value
                                                                    .toInt()));
                                                      },
                                                      activeColor: const Color(
                                                          0xFFEAC578),
                                                      inactiveColor:
                                                          const Color(
                                                                  0xFFEAC578)
                                                              .withOpacity(0.3),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFEAC578),
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                ///////////////////////////// // زر الوصف فوق المفظلة///////////////////////////////
                                Positioned(
                                  bottom: 60,
                                  left: 18,
                                  child: IconButton(
                                    iconSize: 30,
                                    icon: Icon(
                                      Icons.menu_book_rounded,
                                      color: Color(0xFFEAC578),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Color.fromRGBO(36, 36, 36, 1),
                                            title: Text(
                                              state.currentStoryProverb.title,
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                color: Color(0xFFEAC578),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Text(
                                              state.currentStoryProverb
                                                  .description,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color(0xFFEAC578),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'إغلاق',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFFEAC578),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                //      زر المفضلة فوق المؤقت الأيمن
                                if ((context.read<AppUserCubit>().state
                                    is AppUserLoggedIn)) ...{
                                  BlocConsumer<FavoriteStoryProverbBloc,
                                      FavoriteStoryProverbState>(
                                    listener: (context, state) {
                                      // TODO: implement listener
                                      if (state
                                          is FavoriteStoryProverbFailure) {
                                        showSnackBar(context, state.message);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state
                                          is FavoriteStoryProverbLoading) {
                                        return const Positioned(
                                          bottom: 75,
                                          right: 30,
                                          child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: CircularProgressIndicator(
                                              color: Color(0xFFEAC578),
                                            ),
                                          ),
                                        );
                                      }
                                      if (state
                                          is FavoriteStoryProverbSuccess) {
                                        return Positioned(
                                          bottom: 60,
                                          right: 16,
                                          child: FavoriteIconButton(
                                            icon: (state.proverbStory
                                                            .addedToFavorite !=
                                                        null &&
                                                    state.proverbStory
                                                        .addedToFavorite!)
                                                ? Icons.favorite_rounded
                                                : Icons.favorite_border_rounded,
                                            onPressed: () => (state.proverbStory
                                                            .addedToFavorite !=
                                                        null &&
                                                    state.proverbStory
                                                        .addedToFavorite!)
                                                ? context
                                                    .read<
                                                        FavoriteStoryProverbBloc>()
                                                    .add(
                                                      FavoriteStoryProverbRemove(
                                                        id: state.proverbStory
                                                            .proverbStoryId,
                                                      ),
                                                    )
                                                : context
                                                    .read<
                                                        FavoriteStoryProverbBloc>()
                                                    .add(FavoriteStoryProverbAdd(
                                                        id: state.proverbStory
                                                            .proverbStoryId)),
                                          ),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                } else ...{
                                  Container(
                                    child: Icon(Icons.favorite_rounded),
                                  ),
                                },
                                // Positioned(
                                //   bottom: 60,
                                //   right: 16,
                                //   child: IconButton(
                                //     iconSize: 35,
                                //     icon: Icon(
                                //       (state.currentStoryProverb
                                //                       .addedToFavorite !=
                                //                   null &&
                                //               state.currentStoryProverb
                                //                   .addedToFavorite!)
                                //           ? Icons.favorite
                                //           : Icons.favorite_border,
                                //       color: (state.currentStoryProverb
                                //                       .addedToFavorite !=
                                //                   null &&
                                //               state.currentStoryProverb
                                //                   .addedToFavorite!)
                                //           ? Color(0xFFEAC578)
                                //           : Color(0xFFEAC578), // لون الخط
                                //     ),
                                //     onPressed: () {
                                //       if ((state.currentStoryProverb
                                //                   .addedToFavorite !=
                                //               null &&
                                //           state.currentStoryProverb
                                //               .addedToFavorite!)) {
                                //         context
                                //             .read<FavoriteStoryProverbBloc>()
                                //             .add(
                                //               FavoriteStoryProverbAdd(
                                //                 id: state.currentStoryProverb
                                //                     .proverbStoryId,
                                //               ),
                                //             );
                                //       } else {
                                //         context
                                //             .read<FavoriteStoryProverbBloc>()
                                //             .add(
                                //               FavoriteStoryProverbRemove(
                                //                 id: state.currentStoryProverb
                                //                     .proverbStoryId,
                                //               ),
                                //             );
                                //       }
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 0.0),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                      );
                    }
                  },
                ),
              ),
              ///////////////////////////////////////////////////////////////////////////
              Container(
                child: // القائمة السفلية
                    BlocConsumer<ListStoryProverbBloc, ListStoryProverbState>(
                  listener: (context, state) {
                    if (state is ListStoryProverbLoaded) {
                      context.read<PlayerStoryProverbBloc>().add(
                            SelectStoryProverbEvent(
                              storyProverbId:
                                  state.storyProverbs[0].proverbStoryId,
                              isPlay: false,
                            ),
                          );
                      context.read<PlayerStoryProverbBloc>().add(PauseEvent());
                      context.read<FavoriteStoryProverbBloc>().add(
                          FavoriteStoryProverbInit(
                              proverbStory: state.storyProverbs[0]));
                    }
                    if (state is ListStoryProverbFailure) {
                      showSnackBar(context, state.message);
                    }
                    if (state is ListStoryProverbFailure) {
                      context.read<PlayerStoryProverbBloc>().add(
                            SelectStoryProverbEvent(storyProverbId: 'null'),
                          );
                    }
                  },
                  builder: (context, state) {
                    if (state is ListStoryProverbLoading) {
                      return Loader();
                    }
                    if (state is ListStoryProverbLoaded) {
                      context.read<PlayerStoryProverbBloc>().add(PauseEvent());

                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.storyProverbs.length,
                          itemBuilder: (context, index) {
                            final story = state.storyProverbs[index];
                            return GestureDetector(
                              onTap: () {
                                if (story.isFree ||
                                    (context.read<AppUserCubit>().state
                                            is AppUserLoggedIn &&
                                        (context.read<AppUserCubit>().state
                                                    as AppUserLoggedIn)
                                                .user
                                                .customerType ==
                                            'Subscriber')) {
                                  context.read<PlayerStoryProverbBloc>().add(
                                        SelectStoryProverbEvent(
                                          storyProverbId: story.proverbStoryId,
                                        ),
                                      );
                                } else {
                                  showSnackBar(context,
                                      "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستماع لهذا المثل");
                                  if ((context.read<AppUserCubit>().state
                                      is AppUserLoggedIn)) {
                                    navigatorKey.currentState!.push(
                                        SubscriptionManagementPage.route());
                                  }
                                }
                              },
                              child: Container(
                                height: 65,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                // padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(36, 36, 36, 0.7),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // padding: EdgeInsets.all(3.0),
                                      // margin: EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Image.asset(
                                        AppImages.ICON_PLAY,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        story.title,
                                        style: TextStyle(
                                          color: Color(0xFFEAC578),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 22,
                                      icon: Icon(
                                        Icons.menu_book_rounded,
                                        color: Color(0xFFEAC578),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  Color.fromRGBO(36, 36, 36, 1),
                                              title: Text(
                                                story.title,
                                                style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Color(0xFFEAC578),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Text(
                                                story.description,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFFEAC578),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'إغلاق',
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Color(0xFFEAC578),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      formatDuration(story.duration),
                                      style: TextStyle(
                                        color: Color(0xFFEAC578),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    if (story.isFree)
                                      // const Align(
                                      //     alignment: Alignment.topCenter,
                                      //     child: Icon(Icons.bookmark)),
                                      Container(
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color: AppPallete.secondaryColor
                                              .withOpacity(0.9),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Center(
                                            child: Text(
                                              'مجاني',
                                              style: TextStyle(
                                                  color: AppPallete.blackColor
                                                      .withOpacity(1),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    // Row(
                                    //   children: [
                                    //     IconButton(
                                    //       iconSize: 22,
                                    //       icon: Icon(
                                    //         Icons.menu_book_rounded,
                                    //         color: Color(0xFFEAC578),
                                    //       ),
                                    //       onPressed: () {
                                    //         showDialog(
                                    //           context: context,
                                    //           builder: (BuildContext context) {
                                    //             return AlertDialog(
                                    //               backgroundColor:
                                    //                   Color.fromRGBO(
                                    //                       36, 36, 36, 1),
                                    //               title: Text(
                                    //                 story.title,
                                    //                 style: TextStyle(
                                    //                   fontSize: 22.0,
                                    //                   color: Color(0xFFEAC578),
                                    //                 ),
                                    //                 textAlign: TextAlign.center,
                                    //               ),
                                    //               content: Text(
                                    //                 story.description,
                                    //                 style: TextStyle(
                                    //                   fontSize: 16.0,
                                    //                   color: Color(0xFFEAC578),
                                    //                 ),
                                    //                 textAlign: TextAlign.center,
                                    //               ),
                                    //               actions: [
                                    //                 TextButton(
                                    //                   onPressed: () {
                                    //                     Navigator.of(context)
                                    //                         .pop();
                                    //                   },
                                    //                   child: Text(
                                    //                     'إغلاق',
                                    //                     style: TextStyle(
                                    //                       fontSize: 18.0,
                                    //                       color:
                                    //                           Color(0xFFEAC578),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             );
                                    //           },
                                    //         );
                                    //       },
                                    //     ),
                                    //     SizedBox(
                                    //       width: 15,
                                    //     ),
                                    //     Text(
                                    //       formatDuration(story.duration),
                                    //       style: TextStyle(
                                    //         color: Color(0xFFEAC578),
                                    //         fontSize: 14.0,
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     if (story.isFree)
                                    //       // const Align(
                                    //       //     alignment: Alignment.topCenter,
                                    //       //     child: Icon(Icons.bookmark)),
                                    //       Column(
                                    //         children: [
                                    //           Container(
                                    //             width: 25,
                                    //             decoration: BoxDecoration(
                                    //               color: AppPallete
                                    //                   .secondaryColor
                                    //                   .withOpacity(0.9),
                                    //               borderRadius:
                                    //                   const BorderRadius.only(
                                    //                 topLeft:
                                    //                     Radius.circular(10),
                                    //                 bottomLeft:
                                    //                     Radius.circular(10),
                                    //               ),
                                    //             ),
                                    //             child: RotatedBox(
                                    //               quarterTurns: 3,
                                    //               child: Center(
                                    //                 child: Text(
                                    //                   'مجاني',
                                    //                   style: TextStyle(
                                    //                       color: AppPallete
                                    //                           .blackColor
                                    //                           .withOpacity(1),
                                    //                       fontWeight:
                                    //                           FontWeight.bold,
                                    //                       fontSize: 12),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is ListStoryProverbFailure) {
                      return Expanded(
                        child: Center(
                            child: Refresh(
                          message: '${state.message}',
                          onRefresh: () {
                            context.read<ListStoryProverbBloc>().add(
                                GetStoryProverbsEvent(
                                    pageNumber: 1, pageSize: 100));
                          },
                        )),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const FavoriteIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: Color(0xFFEAC578),
        size: 35,
      ),
      onPressed: onPressed,
    );
  }
}
