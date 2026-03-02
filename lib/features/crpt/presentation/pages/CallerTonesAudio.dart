import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/SizeConfigPercentage.dart';
import 'package:qawafi_app/features/crpt/presentation/bloc/CallerTones_bloc.dart';
import 'package:qawafi_app/features/crpt/presentation/bloc/audioPlayer/audio_player_bloc.dart';
import 'package:qawafi_app/features/crpt/presentation/pages/Subcribe2CrptPage.dart';

import '../../../../core/utils/string_from_duration.dart';

class CallerTonesAudio extends StatefulWidget {
  const CallerTonesAudio({required this.id, required this.Name});

  final String id;
  final String Name;

  @override
  State<CallerTonesAudio> createState() => _CallerTonesAudioState();
}

class _CallerTonesAudioState extends State<CallerTonesAudio> {
  @override
  void initState() {
    context.read<CallerTonesBloc>().add(CallerTonesByID(Id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    // context.read<AudioPlayerBloc>().add(PauseAudio()); // تأكد من أن الصوت يتوقف
    // context.read<AudioPlayerBloc>().add(AudioDispose()); // تأكد من أن الصوت يتوقف
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AudioPlayerBloc>().add(PauseAudio()); // تأكد من أن الصوت يتوقف
        context.read<AudioPlayerBloc>().index=-1;   // context.read<AudioPlayerBloc>().add(AudioDispose()); // تأكد من أن الصوت يتوقف
        return true;
      },
      child: ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
          appBar: QawafiAppBar(
            title: "رنات الإنتظار",
          ),
          body: Container(
            child: BlocConsumer<CallerTonesBloc, CallerTonesState>(
              listener: (context, state) {
                if (state is CallerTonesFailure) {
                  Refresh(
                      message: state.message,
                      onRefresh: () => context
                          .read<CallerTonesBloc>()
                          .add(CallerTonesByID(Id: widget.id)));
                }
              },
              builder: (context, state) {
                if (state is CallerTonesLoading) {
                  return Loader();
                }
                if (state is CallerTonesLoaded) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            ' قائمة الرنات الخاصة بـــ   ' + widget.Name,
                            style: TextStyle(
                              color: AppPallete.secondaryColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: state.callerTones.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child:
                                  BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
                                listener: (context, audioState) {
                                  if (audioState is AudioLoaded) {
                                    log("Success AND LOADED");
                                  }
                                  if (audioState is AudioError) {
                                    log("Audio Error : ${audioState.message}");
                                  }
                                  // تنفيذ أي عمليات إضافية عند تغير حالة الصوت هنا إذا لزم الأمر
                                },
                                builder: (context, audioState) {
                                  if (audioState is AudioLoaded &&
                                      context.read<AudioPlayerBloc>().index ==
                                          index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (context
                                                .read<AudioPlayerBloc>()
                                                .isLoading) ...{
                                              SizedBox(
                                                height: 25,
                                                width: 25,
                                                child: Loader(),
                                              )
                                            } else ...{
                                              GestureDetector(
                                                onTap: () {
                                                  if (_isPlaying(audioState)) {
                                                    context
                                                        .read<AudioPlayerBloc>()
                                                        .add(PauseAudio());
                                                  } else {
                                                    // if (audioState is! AudioLoaded) {
      
                                                    // }
                                                    context
                                                        .read<AudioPlayerBloc>()
                                                        .add(LoadAudio(
                                                            index: index,
                                                            url: state
                                                                .callerTones[
                                                                    index]
                                                                .trackSrc));
                                                    context
                                                        .read<AudioPlayerBloc>()
                                                        .add(PlayAudio());
                                                  }
                                                },
                                                child: Icon(
                                                  context
                                                          .read<AudioPlayerBloc>()
                                                          .audioPlayer
                                                          .playing
                                                      ? Icons.pause_circle
                                                      : Icons.play_circle,
                                                  size: 35,
                                                  color:
                                                      AppPallete.secondaryColor,
                                                ),
                                              ),
                                            },
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                state.callerTones[index].toneName,
                                                style: TextStyle(
                                                  color:
                                                      AppPallete.secondaryColor,
                                                  fontSize: 20.0,
                                                ),
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                AppImages.crptAudio,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formatDuration(audioState
                                                  .currentPosition), // Current playback time, should be dynamic
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                              child: Slider(
                                                min: 0.0,
                                                value: audioState
                                                    .currentPosition.inSeconds
                                                    .toDouble(), // Current position of the slider
                                                max: audioState
                                                    .totalDuration.inSeconds
                                                    .toDouble(), // Total duration of the tone
                                                onChanged: (value) {
                                                  // Handle slider value change
                                                  context
                                                      .read<AudioPlayerBloc>()
                                                      .add(
                                                        SeekAudio(
                                                          position: Duration(
                                                            seconds:
                                                                value.toInt(),
                                                          ),
                                                        ),
                                                      );
                                                },
                                                activeColor:
                                                    AppPallete.secondaryColor,
                                                inactiveColor: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              formatDuration(audioState
                                                  .totalDuration), // Total duration, should be dynamic
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'كود المدار  : ' +
                                                      (state.callerTones[index]
                                                                  .toneCodeM !=
                                                              null
                                                          ? state
                                                              .callerTones[index]
                                                              .toneCodeM
                                                              .toString()
                                                          : 'قريباً'),
                                                  style: TextStyle(
                                                    color: AppPallete.whiteColor,
                                                  ),
                                                ),
                                                // Text(
                                                //   'كود الليبيانا: ' +
                                                //       (state.callerTones[index]
                                                //                   .toneCodeL !=
                                                //               null
                                                //           ? state
                                                //               .callerTones[index]
                                                //               .toneCodeL
                                                //               .toString()
                                                //           : 'قريباً'),
                                                //   style: TextStyle(
                                                //     color: AppPallete.whiteColor,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Handle subscription action
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  enableDrag: true,
                                                  constraints: BoxConstraints(
                                                      maxHeight: SizeConfigPercentage
                                                              .blockSizeVertical! *
                                                          70),
                                                  showDragHandle: true,
                                                  backgroundColor:
                                                      AppPallete.whiteColor,
                                                  context: context,
                                                  builder: (context) {
                                                    return Subscribe2CrptPage(
                                                      toneCodeM: state
                                                          .callerTones[index]
                                                          .toneCodeM
                                                          .toString(),
                                                      toneCodeL: state
                                                          .callerTones[index]
                                                          .toneCodeL
                                                          .toString(),
                                                    );
                                                  },
                                                );
                                                // Navigator.push(
                                                //   context,
                                                //   Subscribe2CrptPage.route(
                                                //       toneCodeM: state.callerTones[index].toneCodeM.toString(),
                                                //       toneCodeL: state.callerTones[index].toneCodeL.toString()),
                                                // );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppPallete.secondaryColor,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 40, vertical: 10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: Text(
                                                'إشتراك',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (audioState is AudioLoading) ...{
                                        Stack(
                                          children: [
                                            Positioned(
                                              child: Container(
                                                color: AppPallete.whiteColor
                                                    .withOpacity(0.3),
                                                child: Loader(
                                                  color: AppPallete.blackColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      },
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<AudioPlayerBloc>().add(
                                                  LoadAudio(
                                                      index: index,
                                                      url: state
                                                          .callerTones[index]
                                                          .trackSrc));
                                              context
                                                  .read<AudioPlayerBloc>()
                                                  .add(PlayAudio());
                                            },
                                            child: Icon(
                                              Icons.play_circle,
                                              size: 35,
                                              color: AppPallete.secondaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              state.callerTones[index].toneName,
                                              style: TextStyle(
                                                color: AppPallete.secondaryColor,
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: Image.asset(
                                              AppImages.crptAudio,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'كود المدار  : ' +
                                                    (state.callerTones[index]
                                                                .toneCodeM !=
                                                            null
                                                        ? state.callerTones[index]
                                                            .toneCodeM
                                                            .toString()
                                                        : 'قريباً'),
                                                style: TextStyle(
                                                  color: AppPallete.whiteColor,
                                                ),
                                              ),
                                              // Text(
                                              //   'كود الليبيانا : ' +
                                              //       (state.callerTones[index]
                                              //                   .toneCodeL !=
                                              //               null
                                              //           ? state.callerTones[index]
                                              //               .toneCodeL
                                              //               .toString()
                                              //           : 'قريباً'),
                                              //   style: TextStyle(
                                              //     color: AppPallete.whiteColor,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Handle subscription action
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                enableDrag: true,
                                                constraints: BoxConstraints(
                                                    maxHeight: SizeConfigPercentage
                                                            .blockSizeVertical! *
                                                        70),
                                                showDragHandle: true,
                                                backgroundColor:
                                                    AppPallete.whiteColor,
                                                context: context,
                                                builder: (context) {
                                                  return Subscribe2CrptPage(
                                                    toneCodeM: state
                                                        .callerTones[index]
                                                        .toneCodeM
                                                        .toString(),
                                                    toneCodeL: state
                                                        .callerTones[index]
                                                        .toneCodeL
                                                        .toString(),
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppPallete.secondaryColor,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            child: Text(
                                              'إشتراك',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
      
                if (state is CallerTonesFailure) {
                  return Refresh(
                    message: state.message,
                    onRefresh: () => context
                        .read<CallerTonesBloc>()
                        .add(CallerTonesByID(Id: widget.id)),
                  );
                }
                return Refresh(
                  message: 'مشكلة ما الرجاء المحاولة مجدداً',
                  onRefresh: () => context
                      .read<CallerTonesBloc>()
                      .add(CallerTonesByID(Id: widget.id)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _isPlaying(AudioPlayerState state) {
    log("_isPlaying State " + state.toString());

    return context.read<AudioPlayerBloc>().audioPlayer.playing;
    if (state is AudioLoaded && (state).isPlaying) {
      log("_isPlaying : true");

      return true;
    }
    log("_isPlaying : false");

    return false;
  }
}
