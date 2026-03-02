import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/common/widgets/refresh.dart';
import '../../../../core/common/widgets/background_image_scaffold.dart';
import '../../../audio_player/presentation/bloc/audio_bloc/audio_bloc.dart';
import '../../../../init_dependencies.dart';
import '../bloc/competition_bloc.dart';
import '../bloc/competition_event.dart';
import '../bloc/competition_state.dart';
import '../../domain/entities/competition_entity.dart';
import '../../domain/entities/contestant_result_entity.dart';
import '../utils/competition_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../webview/presentation/pages/auth_webview.dart';

class CompetitionDetailPage extends StatefulWidget {
  final Competition competition;

  const CompetitionDetailPage({
    super.key,
    required this.competition,
  });

  static route(Competition competition) => MaterialPageRoute(
        builder: (context) => CompetitionDetailPage(competition: competition),
      );

  @override
  State<CompetitionDetailPage> createState() => _CompetitionDetailPageState();
}

class _CompetitionDetailPageState extends State<CompetitionDetailPage> {
  Competition? _latestCompetition;

  @override
  void initState() {
    super.initState();
    _latestCompetition = widget.competition;
    _loadContestants();
  }

  void _loadContestants() {
    context.read<CompetitionBloc>().add(GetCompetitionContestantsEvent(widget.competition.competitionId));
  }

  Future<void> _refreshContestants() async {
    _loadContestants();
    // Wait for the state to update
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<CompetitionBloc, CompetitionState>(
            listener: (context, state) {
              if (state is CompetitionContestantsSuccess) {
                _latestCompetition = state.competition;
                if (state.conflictMessage != null) {
                  showDialog(
                    context: context,
                    builder: (context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                        backgroundColor: Colors.black87,
                        title: const Text('تنبيه',
                            style: TextStyle(
                                color: Color(0xFFEAC578), fontFamily: 'Cairo')),
                        content: Text(state.conflictMessage!,
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Cairo')),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('موافق',
                                style: TextStyle(
                                    color: Color(0xFFEAC578),
                                    fontFamily: 'Cairo')),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
              if (state is CompetitionFailure &&
                  state.message.isNotEmpty &&
                  (_latestCompetition?.contestantContentResult.isNotEmpty ?? false)) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
            // Use the latest competition data we have
            Competition competition = _latestCompetition ?? widget.competition;

            // Handle full-screen error state (only if we don't have any contestant data yet)
            if (state is CompetitionFailure && (competition.contestantContentResult.isEmpty)) {
              return CustomScrollView(
                slivers: [
                  _buildSliverAppBar(context, competition),
                  SliverFillRemaining(
                    child: Refresh(
                      message: state.message,
                      onRefresh: _loadContestants,
                      height: 100,
                    ),
                  ),
                ],
              );
            }

            return RefreshIndicator(
              onRefresh: _refreshContestants,
              color: AppPallete.gradient1,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(context, competition),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'الوصف',
                            style: TextStyle(
                              color: Color(0xFFEAC578),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            competition.competitionDescription,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Cairo',
                              height: 1.6,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'المشاركين',
                            style: TextStyle(
                              color: Color(0xFFEAC578),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  // Loading state - only show if we have NO data
                  if (state is CompetitionLoading && competition.contestantContentResult.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Loader(),
                        ),
                      ),
                    ),
                  // Error state - only show if we have NO data
                  if (state is CompetitionFailure && competition.contestantContentResult.isEmpty)
                    SliverToBoxAdapter(
                      child: Refresh(
                        message: state.message,
                        onRefresh: _loadContestants,
                        height: 80,
                      ),
                    ),
                  // Empty state
                  if (state is CompetitionContestantsSuccess && competition.contestantContentResult.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Text(
                            'لا يوجد متسابقين حالياً',
                            style: TextStyle(color: Colors.white54, fontFamily: 'Cairo', fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  // Contestants list
                  if (competition.contestantContentResult.isNotEmpty) ...[
                    // Active Contestants
                    if (competition.contestantContentResult
                        .where((c) => !c.eliminated)
                        .isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 16, right: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final activeContestants = competition
                                  .contestantContentResult
                                  .where((c) => !c.eliminated)
                                  .toList();
                              final contestant = activeContestants[index];
                              return ContestantCard(
                                key: ValueKey(contestant.contestantId),
                                contestant: contestant,
                                rank: index + 1,
                                competitionId: competition.competitionId,
                              );
                            },
                            childCount: competition.contestantContentResult
                                .where((c) => !c.eliminated)
                                .length,
                          ),
                        ),
                      ),

                    // Elimination Separator
                    if (competition.contestantContentResult
                        .any((c) => c.eliminated))
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(color: Colors.white24),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'تم الإقصاء من المسابقة',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: Colors.white24),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Eliminated Contestants
                    if (competition.contestantContentResult
                        .where((c) => c.eliminated)
                        .isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.only(
                            bottom: 40, left: 16, right: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final eliminatedContestants = competition
                                  .contestantContentResult
                                  .where((c) => c.eliminated)
                                  .toList();
                              final contestant = eliminatedContestants[index];
                              // Start rank after the last active contestant
                              final activeCount = competition
                                  .contestantContentResult
                                  .where((c) => !c.eliminated)
                                  .length;
                              return ContestantCard(
                                key: ValueKey(contestant.contestantId),
                                contestant: contestant,
                                rank: activeCount + index + 1,
                                competitionId: competition.competitionId,
                              );
                            },
                            childCount: competition.contestantContentResult
                                .where((c) => c.eliminated)
                                .length,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}

  Widget _buildSliverAppBar(BuildContext context, Competition competition) {
    return SliverAppBar(
      expandedHeight: 350,
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              competition.imageSrc.replaceFirst(':5000', ':5099'),
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.95),
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  competition.isRunning ? 'مستمر' : 'منتهية',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    Text(
                      '${competition.totalNumberOfContestant}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.people_outline, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    competition.competitionName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${competition.contestantContentResult.length} شاعر',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          color: Color(0xFFEAC578), size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'تاريخ انتهاء المسابقة: ${competition.endDate.day} ${_getMonthName(competition.endDate.month)} ${competition.endDate.year}',
                        style: const TextStyle(
                          color: Color(0xFFEAC578),
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return months[month - 1];
  }
}

class ContestantCard extends StatefulWidget {
  final ContestantResult contestant;
  final int rank;
  final String competitionId;

  const ContestantCard({
    super.key,
    required this.contestant,
    required this.rank,
    required this.competitionId,
  });

  @override
  State<ContestantCard> createState() => _ContestantCardState();
}

class _ContestantCardState extends State<ContestantCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Rank Badge (Right Side in RTL)
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.contestant.eliminated
                      ? Colors.grey // Grey for eliminated
                      : const Color(0xFFB07D3E), // Gold for active
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '#${widget.rank}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Card Main Body
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                    image: const DecorationImage(
                      image: AssetImage(AppImages.qawafiLogoBg),
                      opacity: 0.1,
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header Row
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: const Color(0xFFEAC578).withOpacity(0.3),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  widget.contestant.trackImage.replaceFirst(':5000', ':5099'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.contestant.contestantName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    widget.contestant.contestantDescription,
                                    style: const TextStyle(
                                      color: Color(0xFFEAC578),
                                      fontSize: 12,
                                      fontFamily: 'Cairo',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFEAC578).withOpacity(0.5)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Color(0xFFEAC578), size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.contestant.numberOfVotes}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => setState(() => _isExpanded = !_isExpanded),
                              child: Icon(
                                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: Colors.white70,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expanded Section
                      if (_isExpanded)
                        BlocProvider(
                          create: (context) => AudioBloc(AudioPlayer(), serviceLocator())
                            ..add(LoadAudio(
                              url: widget.contestant.tracksrc.replaceFirst(':5000', ':5099'),
                              headers: {},
                            )),
                          child: ContestantExpandedSection(
                            contestant: widget.contestant,
                            competitionId: widget.competitionId,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContestantExpandedSection extends StatelessWidget {
  final ContestantResult contestant;
  final String competitionId;

  const ContestantExpandedSection({
    super.key,
    required this.contestant,
    required this.competitionId,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEAC578).withOpacity(0.1)),
                ),
                child: Text(
                  contestant.trackDescription,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    height: 1.8,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 16),
              // Player Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: state is AudioLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            color: Color(0xFFEAC578),
                          ),
                        ),
                      )
                    : state is AudioLoaded
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'مشاركة ' + contestant.contestantName,
                                      style: const TextStyle(
                                        color: Color(0xFFEAC578),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(
                                      state.isPlaying
                                          ? Icons.pause_circle_filled
                                          : Icons.play_circle_filled,
                                      color: const Color(0xFFEAC578),
                                      size: 36,
                                    ),
                                    onPressed: () {
                                      if (state.isPlaying) {
                                        context.read<AudioBloc>().add(PauseAudio());
                                      } else {
                                        context.read<AudioBloc>().add(PlayAudio());
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbColor: const Color(0xFFEAC578),
                                  activeTrackColor: const Color(0xFFEAC578),
                                  inactiveTrackColor: Colors.white10,
                                  trackHeight: 2,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
                                ),
                                child: Slider(
                                  value: state.currentPosition.inSeconds.toDouble(),
                                  max: state.totalDuration.inSeconds.toDouble() > 0
                                      ? state.totalDuration.inSeconds.toDouble()
                                      : 1.0,
                                  onChanged: (value) {
                                    context.read<AudioBloc>().add(
                                          SeekAudio(
                                            position: Duration(seconds: value.toInt()),
                                          ),
                                        );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(state.currentPosition),
                                      style: const TextStyle(color: Colors.white38, fontSize: 10),
                                    ),
                                    Text(
                                      _formatDuration(state.totalDuration),
                                      style: const TextStyle(color: Colors.white38, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : state is AudioError
                            ? Center(
                                child: Text(
                                  'خطأ في تحميل الملف الصوتي',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              )
                            : const SizedBox(),
              ),
              const SizedBox(height: 16),
 
              ElevatedButton(
                onPressed: contestant.eliminated
                    ? null
                    : () {
                        final userState = context.read<AppUserCubit>().state;
                        if (userState is AppUserLoggedIn) {
                          if (contestant.userVoteFlag) {
                              showDialog(
                                context: context,
                                builder: (context) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: AlertDialog(
                                    backgroundColor: Colors.black87,
                                    title: const Text('تنبيه',
                                        style: TextStyle(
                                            color: Color(0xFFEAC578),
                                            fontFamily: 'Cairo')),
                                    content: const Text(
                                        'هل أنت متأكد من إلغاء التصويت؟',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Cairo')),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('إلغاء',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Cairo')),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<CompetitionBloc>().add(
                                              UnVoteContestantEvent(
                                                  contestant.trackId,
                                                  competitionId));
                                          Navigator.pop(context);
                                        },
                                        child: const Text('تأكيد',
                                            style: TextStyle(
                                                color: Color(0xFFD32F2F),
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              // userVoteFlag is null or false
                              context
                                  .read<CompetitionBloc>()
                                  .add(VoteContestantEvent(
                                    contestant.trackId,
                                    competitionId,
                                  ));
                            }
                        } else {
                          // المستخدم غير مسجل
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.black87,
                                title: Center(
                                    child: Text(
                                  "تنبيه",
                                  style: TextStyle(
                                    color: AppPallete.libyanTitlesCardsTitleColor,
                                    fontFamily: 'Cairo',
                                  ),
                                )),
                                content: const Text(
                                  "عفواً لست مسجلاً، الرجاء التسجيل حتى يمكنك الإستمتاع بهذا المحتوى",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Center(
                                        child: Text(
                                      "اشترك الأن",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppPallete.libyanTitlesCardsTitleColor,
                                        fontFamily: 'Cairo',
                                      ),
                                    )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      navigatorKey.currentState!.push(FlutterWebView.route());
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: contestant.userVoteFlag == true
                      ? const Color(0xFFD32F2F)
                      : const Color(0xFFB07D3E),
                  disabledBackgroundColor: Colors.grey,
                  disabledForegroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  contestant.eliminated
                      ? 'تم الإقصاء'
                      : (contestant.userVoteFlag == true
                          ? 'إلغاء التصويت'
                          : 'تصويت للشاعر'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
