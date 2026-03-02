import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/common/widgets/refresh.dart';
import '../../../../core/theme/app_pallete.dart';
import '../bloc/competition_bloc.dart';
import '../bloc/competition_event.dart';
import '../bloc/competition_state.dart';
import '../utils/competition_styles.dart';
import '../widgets/competition_card.dart';
import 'competition_detail_page.dart';

class CompetitionListPage extends StatefulWidget {
  const CompetitionListPage({super.key});

  @override
  State<CompetitionListPage> createState() => _CompetitionListPageState();
static const String routeName = '/CompetitionListPage';
  static Route<Object?> route() => MaterialPageRoute(
        builder: (context) => const CompetitionListPage(),
        settings: const RouteSettings(name: routeName),
      );
}
  
  
class _CompetitionListPageState extends State<CompetitionListPage> {
  @override
  void initState() {
    super.initState();
    _loadCompetitions();
  }

  void _loadCompetitions() {
    context.read<CompetitionBloc>().add(GetCompetitionsEvent());
  }

  Future<void> _refreshCompetitions() async {
    context.read<CompetitionBloc>().add(RefreshCompetitionsEvent());
    // Wait for the state to update
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'المسابقات'),
        body: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Cairo'),
          child: BlocBuilder<CompetitionBloc, CompetitionState>(
        builder: (context, state) {
          if (state is CompetitionLoading) {
            return const Center(child: Loader());
          }
          if (state is CompetitionFailure) {
            return Refresh(
              message: state.message,
              onRefresh: _loadCompetitions,
            );
          }
          // If we have success list, show it
          if (state is CompetitionSuccess) {
            return RefreshIndicator(
              onRefresh: _refreshCompetitions,
              color: AppPallete.gradient1,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.competitions.length,
                itemBuilder: (context, index) {
                  final competition = state.competitions[index];
                  return CompetitionCard(
                    competition: competition,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompetitionDetailPage(
                            competition: competition,
                          ),
                        ),
                      );
                      // Reload competitions when returning from detail page
                      if (mounted) _loadCompetitions();
                    },
                  );
                },
              ),
            );
          }
          // If we are in detail page state (ContestantsSuccess), we might want to show loading or keep the old list if possible.
          // Since we don't have the old list here easily without state persistence, we show a loader.
          if (state is CompetitionContestantsSuccess) {
            return const Center(
              child: Loader(),
            );
          }
          return const SizedBox();
        },
      ),
    ),),);
  }
}
