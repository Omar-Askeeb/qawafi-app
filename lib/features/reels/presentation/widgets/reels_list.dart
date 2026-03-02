import 'package:flutter/material.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/localStorage/loacal_storage.dart';
import '../../../../core/utils/nav_index_singleton.dart';
import '../../../../init_dependencies.dart';
import '../../data/models/reel_model.dart';

class ReelItem extends StatefulWidget {
  final ReelModel reel;
  final bool isActive;

  const ReelItem({super.key, required this.reel, required this.isActive});

  @override
  _ReelItemState createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  VideoPlayerController? _controller;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = serviceLocator<LocalStorage>();
    initVideo();
  }

  Future<void> initVideo() async {
    String token = await _localStorage.accessToken;
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.reel.videoSrc),
      httpHeaders: {
        'Authorization': token,
      },
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );

    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.setLooping(true);
    // _controller.initialize();

    // if (widget.isActive) {
    //   _controller.initialize().then((_) {
    //     _controller.play();
    //   });
    // }

    if (widget.isActive) {
      if (!_controller!.value.isInitialized) {
        _controller?.initialize().then((_) {
          if (NavSingleton().intValue == 2) {
            _controller!.play();
          }
        });
      } else {
        if (NavSingleton().intValue == 2) {
          _controller!.play();
        }
      }
    } else {
      _controller!.pause();
    }
  }

  @override
  void didUpdateWidget(ReelItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      if (!_controller!.value.isInitialized) {
        _controller!.initialize().then((_) {
          if (NavSingleton().intValue == 2) {
            _controller!.play();
          }
        });
      } else {
        if (NavSingleton().intValue == 2) {
          _controller!.play();
        }
      }
    } else {
      _controller!.pause();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null
        ? Stack(
            children: [
              Center(
                child: _controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      )
                    : const CircularProgressIndicator(
                        color: AppPallete.whiteColor),
              ),
              _ControlsOverlay(controller: _controller!),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // bottom: 200,
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                            playedColor: AppPallete.secondaryColor,
                            bufferedColor: AppPallete.greyColor),
                      ))),
              Positioned(
                bottom: 50,
                right: 20,
                child: DefaultTextStyle(
                  style: const TextStyle(fontFamily: 'Cairo'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.LOGO,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.reel.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(widget.reel.description,
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : controller.value.isBuffering
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppPallete.whiteColor,
                      backgroundColor: AppPallete.greyColor,
                    ))
                  : controller.value.isInitialized
                      ? const ColoredBox(
                          color: Colors.black26,
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 100.0,
                              semanticLabel: 'Play',
                            ),
                          ),
                        )
                      : Container(),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
