import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_competitions.dart';
import '../../domain/usecases/get_competition_contestants.dart';
import '../../domain/usecases/vote_contestant.dart';
import '../../domain/usecases/unvote_contestant.dart';
import '../../domain/entities/competition_entity.dart';
import '../../domain/entities/contestant_result_entity.dart';
import 'competition_event.dart';
import 'competition_state.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final GetCompetitions _getCompetitions;
  final GetCompetitionContestants _getCompetitionContestants;
  final VoteContestant _voteContestant;
  final UnVoteContestant _unVoteContestant;

  CompetitionBloc({
    required GetCompetitions getCompetitions,
    required GetCompetitionContestants getCompetitionContestants,
    required VoteContestant voteContestant,
    required UnVoteContestant unVoteContestant,
  })  : _getCompetitions = getCompetitions,
        _getCompetitionContestants = getCompetitionContestants,
        _voteContestant = voteContestant,
        _unVoteContestant = unVoteContestant,
        super(CompetitionInitial()) {
    on<GetCompetitionsEvent>(_onGetCompetitions);
    on<RefreshCompetitionsEvent>(_onGetCompetitions);
    on<GetCompetitionContestantsEvent>(_onGetCompetitionContestants);
    on<VoteContestantEvent>(_onVoteContestant);
    on<UnVoteContestantEvent>(_onUnVoteContestant);
  }

  void _onGetCompetitions(
    CompetitionEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    emit(CompetitionLoading());
    final res = await _getCompetitions(NoParams());

    res.fold(
      (l) => emit(CompetitionFailure(l.message)),
      (r) => emit(CompetitionSuccess(r)),
    );
  }

  void _onGetCompetitionContestants(
    GetCompetitionContestantsEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    emit(CompetitionLoading());
    final res = await _getCompetitionContestants(event.id);

    res.fold(
      (l) => emit(CompetitionFailure(l.message)),
      (r) => emit(CompetitionContestantsSuccess(r)),
    );
  }

  void _onVoteContestant(
    VoteContestantEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    final currentState = state;
    if (currentState is CompetitionContestantsSuccess) {
        // Optimistic update could go here, but for now lets just load
    }
    
    // We don't want to show full screen loading for a vote, maybe just reload silently or handle in UI
    // But for simplicity, let's just call the API and then reload the competition details
    
    final res = await _voteContestant(event.trackId);
    
    res.fold(
      (l) {
        if (l is ConflictFailure) {
          if (state is CompetitionContestantsSuccess) {
            final currentComp = (state as CompetitionContestantsSuccess).competition;
            emit(CompetitionContestantsSuccess(currentComp, conflictMessage: l.message));
            add(GetCompetitionContestantsEvent(event.competitionId));
          } else {
            emit(CompetitionFailure(l.message));
          }
        } else {
          emit(CompetitionFailure(l.message));
        }
      },
      (r) {
        // Optimistic update
        if (state is CompetitionContestantsSuccess) {
          final currentComp = (state as CompetitionContestantsSuccess).competition;
          final updatedContestants = currentComp.contestantContentResult.map((c) {
            if (c.trackId == event.trackId) {
              return ContestantResult(
                trackId: c.trackId,
                contestantId: c.contestantId,
                contestantName: c.contestantName,
                contestantDescription: c.contestantDescription,
                phoneNumber: c.phoneNumber,
                numberOfVotes: c.numberOfVotes + 1,
                contestantImageSrc: c.contestantImageSrc,
                created: c.created,
                createdBy: c.createdBy,
                lastModified: c.lastModified,
                lastModifiedBy: c.lastModifiedBy,
                isDisabled: c.isDisabled,
                trackDescription: c.trackDescription,
                tracksrc: c.tracksrc,
                trackImage: c.trackImage,
                duration: c.duration,
                competitionName: c.competitionName,
                competitionId: c.competitionId,
                isWinner: c.isWinner,
                userVoteFlag: true,
                winningDate: c.winningDate,
                eliminated: c.eliminated,
                eliminatedDate: c.eliminatedDate,
              );
            }
            return c;
          }).toList();

          final updatedComp = Competition(
            competitionId: currentComp.competitionId,
            competitionName: currentComp.competitionName,
            competitionDescription: currentComp.competitionDescription,
            imageSrc: currentComp.imageSrc,
            endDate: currentComp.endDate,
            isRunning: currentComp.isRunning,
            totalNumberOfContestant: currentComp.totalNumberOfContestant,
            contestantContentResult: updatedContestants,
          );
          emit(CompetitionContestantsSuccess(updatedComp));
        }
        
        // Refresh anyway to be sure and update other potentially changed data
        add(GetCompetitionContestantsEvent(event.competitionId));
      },
    );
  }

  void _onUnVoteContestant(
    UnVoteContestantEvent event,
    Emitter<CompetitionState> emit,
  ) async {
      final res = await _unVoteContestant(event.trackId);
      res.fold(
          (l) => emit(CompetitionFailure(l.message)),
          (r) {
            // Optimistic update
            if (state is CompetitionContestantsSuccess) {
              final currentComp = (state as CompetitionContestantsSuccess).competition;
              final updatedContestants = currentComp.contestantContentResult.map((c) {
                if (c.trackId == event.trackId) {
                  return ContestantResult(
                    trackId: c.trackId,
                    contestantId: c.contestantId,
                    contestantName: c.contestantName,
                    contestantDescription: c.contestantDescription,
                    phoneNumber: c.phoneNumber,
                    numberOfVotes: c.numberOfVotes > 0 ? c.numberOfVotes - 1 : 0,
                    contestantImageSrc: c.contestantImageSrc,
                    created: c.created,
                    createdBy: c.createdBy,
                    lastModified: c.lastModified,
                    lastModifiedBy: c.lastModifiedBy,
                    isDisabled: c.isDisabled,
                    trackDescription: c.trackDescription,
                    tracksrc: c.tracksrc,
                    trackImage: c.trackImage,
                    duration: c.duration,
                    competitionName: c.competitionName,
                    competitionId: c.competitionId,
                    isWinner: c.isWinner,
                    userVoteFlag: false,
                    winningDate: c.winningDate,
                    eliminated: c.eliminated,
                    eliminatedDate: c.eliminatedDate,
                  );
                }
                return c;
              }).toList();

              final updatedComp = Competition(
                competitionId: currentComp.competitionId,
                competitionName: currentComp.competitionName,
                competitionDescription: currentComp.competitionDescription,
                imageSrc: currentComp.imageSrc,
                endDate: currentComp.endDate,
                isRunning: currentComp.isRunning,
                totalNumberOfContestant: currentComp.totalNumberOfContestant,
                contestantContentResult: updatedContestants,
              );
              emit(CompetitionContestantsSuccess(updatedComp));
            }
            add(GetCompetitionContestantsEvent(event.competitionId));
          }
      );
  }
}
