import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/quatrains/domain/entites/quatrain.dart';
import 'package:qawafi_app/init_dependencies.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/localStorage/loacal_storage.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/string_from_duration.dart';
import '../../../quatrains/data/models/quatrain_model.dart';
import '../../../quatrains/presentation/bloc/favorite/favorite_quatrain_bloc.dart';
import '../bloc/audio_bloc.dart';

import 'package:just_audio/just_audio.dart';

class QuatrainAudioPlayerScreen extends StatefulWidget {
  static const String routeName = 'QuatrainAudioPlayer';
  final QuatrainModel quatrain;

  const QuatrainAudioPlayerScreen({super.key, required this.quatrain});
  static route(QuatrainModel quatrain) => MaterialPageRoute(
        builder: (context) => QuatrainAudioPlayerScreen(quatrain: quatrain),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<QuatrainAudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<QuatrainAudioPlayerScreen> {
  late LocalStorage _localStorage;
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _localStorage = serviceLocator<LocalStorage>();
    context
        .read<FavoriteQuatrainBloc>()
        .add(FavoriteQuatrainInit(quatrain: widget.quatrain));
    _initializeToken();
  }

  Future<void> _initializeToken() async {
    final retrievedToken = await _localStorage.accessToken;

    token = retrievedToken;
    log('TOKEN: ' + token);
    setState(() {
      _loadAudio = LoadAudio(url: widget.quatrain.trackSrc, headers: {
        'Authorization': token,
      });
      // _loadAudio = LoadAudio(url: widget.poem.fileSrc, headers: {
      //   'Authorization': token,
      // });
    });
  }

  LoadAudio? _loadAudio;

  @override
  void dispose() {
    // AudioBloc(AudioPlayer()).add(AudioDispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.quatrain.imageSrc);
    return Stack(
      children: [
        Positioned.fill(
          bottom: SizeConfig.screenHeight! * 0.25,
          child: Image.network(
            widget.quatrain.imageSrc,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppImages.AUDIO_PLAYER_BACKGROUND,
                fit: BoxFit.fill,
              );
            },
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
                Colors.grey.withOpacity(0.3), // Grey with more transparency
                Colors.black.withOpacity(0.8), // Almost black with high opacity
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
        //     height: 500,
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         stops: const [0, 20],
        //         colors: [
        //           AppPallete.blackColor.withOpacity(0.05),
        //           AppPallete.blackColor,
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Scaffold(
          appBar: QawafiAppBar(title: ''),
          body: _loadAudio != null
              ? BlocProvider(
                  create: (context) =>
                      AudioBloc(AudioPlayer(), serviceLocator())
                        ..add(_loadAudio!)
                        ..add(PlayAudio()),
                  child: AudioPlayerView(quatrain: widget.quatrain),
                )
              : Container(),
        ),
      ],
    );
  }
}

class AudioPlayerView extends StatelessWidget {
  final Quatrain quatrain;

  const AudioPlayerView({super.key, required this.quatrain});
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                      quatrain.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 30, color: AppPallete.secondaryColor),
                    ),
                  ),
                ),
                // Text(poem.poet),
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
                    const Icon(
                      Icons.replay_10_rounded,
                      color: AppPallete.transparentColor,
                      size: 30,
                    ),
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
                      BlocConsumer<FavoriteQuatrainBloc, FavoriteQuatrainState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is FavoriteQuatrainFailure) {
                            showSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          if (state is FavoriteQuatrainLoading) {
                            return const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: AppPallete.whiteColor,
                                ));
                          }
                          if (state is FavoriteQuatrainSuccess) {
                            return FavoriteIconButton(
                              icon: (state.quatrain.addedToFavorite != null &&
                                      state.quatrain.addedToFavorite!)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              onPressed: () =>
                                  (state.quatrain.addedToFavorite != null &&
                                          state.quatrain.addedToFavorite!)
                                      ? context
                                          .read<FavoriteQuatrainBloc>()
                                          .add(
                                            FavoriteQuatrainRemove(
                                              id: state.quatrain.quatrainsId,
                                            ),
                                          )
                                      : context
                                          .read<FavoriteQuatrainBloc>()
                                          .add(FavoriteQuatrainAdd(
                                              id: state.quatrain.quatrainsId)),
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
                      Container(),
                    }
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
