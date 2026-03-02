import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/audio_player/presentation/bloc/bloc/poem_bloc_bloc.dart';
import 'package:qawafi_app/features/poem/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:qawafi_app/init_dependencies.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/string_from_duration.dart';
import '../../../poem/domain/entites/poem.dart';
import '../bloc/audio_bloc/audio_bloc.dart';

import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  static const String routeName = 'AudioPlayer';
  final Poem poem;

  const AudioPlayerScreen({super.key, required this.poem});
  static route(Poem poem) => MaterialPageRoute(
        builder: (context) => AudioPlayerScreen(poem: poem),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late LocalStorage _localStorage;
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<PoemBlocBloc>()
        .add(PoemBlocFetchEvent(poemId: widget.poem.poemId));
    context.read<FavoriteBloc>().add(FavoriteInit(poem: widget.poem));
    _localStorage = serviceLocator<LocalStorage>();
    _initializeToken();
  }

  Future<void> _initializeToken() async {
    final retrievedToken = await _localStorage.accessToken;

    token = retrievedToken;
    log('TOKEN: ' + token);
    setState(() {
      _loadAudio = LoadAudio(url: widget.poem.fileSrc, headers: {
        'Authorization': token,
      });
    });
  }

  // @override
  // didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  // @override
  // void didUpdateWidget(AudioPlayerScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (ModalRoute.of(context)?.settings.name == AudioPlayerScreen.routeName &&
  //       NavSingleton().intValue == 1) {
  //     context.read<AudioBloc>().add(PauseAudio());
  //   }
  //   log('ROUTE: ' + (ModalRoute.of(context)?.settings.name ?? 'SSS'));
  // }

  LoadAudio? _loadAudio;

  @override
  void dispose() {
    // AudioBloc(AudioPlayer()).add(AudioDispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoemBlocBloc, PoemBlocState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is PoemBlocFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is PoemBlocLoading) {
          return const Loader();
        }
        if (state is PoemBlocLoaded) {
          return Stack(
            children: [
              Positioned.fill(
                bottom: SizeConfig.screenHeight! * 0.25,
                child: Image.network(
                  state.poem.purposeModel?.imageSrc ??
                      AppImages.AUDIO_PLAYER_BACKGROUND,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                      0.0, // Start of the gradient
                      0.3, // 30% of the way down the screen
                      0.6, // 60% of the way down the screen
                      1.0, // End of the gradient
                    ],
                    colors: [
                      const Color(0xFFD9D9D9)
                          .withOpacity(0.1), // Light grey with opacity
                      Colors.grey
                          .withOpacity(0.3), // Grey with more transparency
                      Colors.black
                          .withOpacity(0.8), // Almost black with high opacity
                      AppPallete.blackColor,
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Container(
              //     // height: 500,
              //     height: double.infinity,
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         stops: const [0, 20],
              //         colors: [
              //           AppPallete.blackColor.withOpacity(0.3),
              //           Color.fromARGB(255, 234, 11, 11),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Scaffold(
                appBar: const QawafiAppBar(title: ''),
                body: _loadAudio != null
                    ? BlocProvider(
                        create: (context) =>
                            AudioBloc(AudioPlayer(), serviceLocator())
                              ..add(_loadAudio!)
                              ..add(PlayAudio()),
                        child: AudioPlayerView(
                          poem: widget.poem,
                        ),
                      )
                    : Container(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class AudioPlayerView extends StatelessWidget {
  final Poem poem;

  const AudioPlayerView({super.key, required this.poem});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        if (state is AudioLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AudioLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 160,
                ),
                Text(
                  poem.title,
                  style: const TextStyle(
                      fontSize: 30, color: AppPallete.secondaryColor),
                ),
                Text(poem.poet),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatDuration(state.totalDuration)),
                      Text(formatDuration(state.currentPosition)),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // trackShape: RectangularSliderTrackShape(),
                    trackHeight: 6,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Slider(
                      min: 0.0,
                      max: state.totalDuration.inSeconds.toDouble(),
                      activeColor: AppPallete.secondaryColor,
                      inactiveColor: AppPallete.whiteColor,
                      value: state.currentPosition.inSeconds.toDouble(),
                      onChanged: (value) {
                        context.read<AudioBloc>().add(
                              SeekAudio(
                                position: Duration(
                                  seconds: value.toInt(),
                                ),
                              ),
                            );
                      },
                    ),
                  ),
                ),
                // Text(
                //     '${state.currentPosition.toString().split('.').first} / ${state.totalDuration.toString().split('.').first}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 22,
                      icon: Icon(
                        Icons.menu_book_rounded,
                        color: Color.fromARGB(255, 229, 227, 224),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DefaultTextStyle(
                              style: TextStyle(fontFamily: 'Cairo'),
                              child: AlertDialog(
                                backgroundColor: Color.fromRGBO(36, 36, 36, 1),
                                title: Text(
                                  poem.title,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFFEAC578),
                                    fontFamily: 'Cairo',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  poem.description,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppPallete.whiteColor,
                                    fontFamily: 'Cairo',
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
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // const Icon(
                    //   Icons.replay_10_rounded,
                    //   color: AppPallete.transparentColor,
                    //   size: 30,
                    // ),
                    IconButton(
                      icon: const Icon(
                        Icons.forward_10_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        context.read<AudioBloc>().add(SkipForward());
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        state.isPlaying
                            ? context.read<AudioBloc>().add(PauseAudio())
                            : context.read<AudioBloc>().add(PlayAudio());
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.replay_10_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        context.read<AudioBloc>().add(SkipBackward());
                      },
                    ),
                    if ((context.read<AppUserCubit>().state
                        is AppUserLoggedIn)) ...{
                      BlocConsumer<FavoriteBloc, FavoriteState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is FavoriteFailure) {
                            showSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          if (state is FavoriteLoading) {
                            return const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: AppPallete.whiteColor,
                                ));
                          }
                          if (state is FavoriteSuccess) {
                            return FavoriteIconButton(
                              icon: state.poem.addedToFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              onPressed: () => state.poem.addedToFavorite
                                  ? context.read<FavoriteBloc>().add(
                                      FavoriteRemove(poemId: state.poem.poemId))
                                  : context.read<FavoriteBloc>().add(
                                      FavoriteAdd(poemId: state.poem.poemId)),
                            );
                          }
                          return Container();
                          // return IconButton(
                          //   icon: const Icon(
                          //     Icons.favorite_border_outlined,
                          //     size: 30,
                          //   ),
                          //   onPressed: () {
                          //     context.read<AudioBloc>().add(SkipForward());
                          //   },
                          // );
                        },
                      ),
                    } else ...{
                      const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                    },
                  ],
                ),
              ],
            ),
          );
        } else if (state is AudioError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container();
        }
      },
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
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
}
