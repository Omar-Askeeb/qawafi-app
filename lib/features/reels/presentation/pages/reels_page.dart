import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/features/home/presentation/pages/libyan_name.dart';
import 'package:qawafi_app/features/reels/presentation/bloc/reels_bloc.dart';

import '../../../../core/utils/nav_index_singleton.dart';
import '../widgets/reels_list.dart';

class ReelsPage extends StatefulWidget {
  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage>
    with AutomaticKeepAliveClientMixin {
  bool _isInit = false;
  bool _isActive = false;
  bool isScroll = false;

  @override
  void initState() {
    super.initState();
    // Start initializing the reels when the page is first shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        // _startVideo();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit && ModalRoute.of(context)?.isCurrent == true) {
      context.read<ReelsBloc>().add(FetchReelsEvent());
      _isInit = true;
    }
  }

  @override
  void didUpdateWidget(ReelsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Debugging: Print current route name
    String currentRouteName =
        ModalRoute.of(context)?.settings.name ?? 'Unknown';
    log('Currentx route: $currentRouteName');

    // Check if ReelsPage is currently active

    // Update video playback based on ReelsPage's active state
    if (NavSingleton().intValue == 2 && !_isActive) {
      _startVideo();
    } else if (NavSingleton().intValue != 2 && _isActive) {
      _stopVideo();
    }
  }

  _setIsScroll(bool value) {
    isScroll = value;
  }

  @override
  void dispose() {
    _isActive = false;
    super.dispose();
  }

  void _startVideo() {
    setState(() {
      _isActive = true;
    });
  }

  void _stopVideo() {
    setState(() {
      _isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ReelsView(isActive: _isActive, setIsScroll: _setIsScroll),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ReelsView extends StatelessWidget {
  final bool isActive;
  final Function(bool) setIsScroll;
  const ReelsView({
    required this.isActive,
    required this.setIsScroll,
  });
  @override
  Widget build(BuildContext context) {
    log(ModalRoute.of(context)?.settings.name ?? 'UNK');
    return BlocBuilder<ReelsBloc, ReelsState>(
      builder: (context, state) {
        if (state is ReelsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReelsSuccess) {
          if (state.reels.length == 0) {
               return LibyanNamePlaceholder(title: 'مقاطع فيديو قصيرة',);
          } else {
            return PageView.builder(
              onPageChanged: (index) {
                setIsScroll(true);
              },
              scrollDirection: Axis.vertical,
              itemCount: state.reels.length,
              itemBuilder: (context, index) {
                final reel = state.reels[index];
                return ReelItem(reel: reel, isActive: isActive);
              },
            );
          }
        } else if (state is ReelsFailure) {
          return Refresh(
            message: state.message,
            onRefresh: () => context.read<ReelsBloc>().add(
                  FetchReelsEvent(),
                ),
          );
        } else {
          return const Center(child: Text('No reels available'));
        }
      },
    );
  }
}
