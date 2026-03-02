class ContestantResult {
  final String trackId;
  final String contestantId;
  final String contestantName;
  final String contestantDescription;
  final int phoneNumber;
  final int numberOfVotes;
  final String contestantImageSrc;
  final DateTime created;
  final String createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final bool isDisabled;
  final String trackDescription;
  final String tracksrc;
  final String trackImage;
  final String duration;
  final String competitionName;
  final String competitionId;
  final bool isWinner;
  final bool userVoteFlag;
  final DateTime? winningDate;
  final bool eliminated;
  final DateTime? eliminatedDate;

  ContestantResult({
    required this.trackId,
    required this.contestantId,
    required this.contestantName,
    required this.contestantDescription,
    required this.phoneNumber,
    required this.numberOfVotes,
    required this.contestantImageSrc,
    required this.created,
    required this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    required this.isDisabled,
    required this.trackDescription,
    required this.tracksrc,
    required this.trackImage,
    required this.duration,
    required this.competitionName,
    required this.competitionId,
    required this.isWinner,
    this.userVoteFlag = false,
    this.winningDate,
    required this.eliminated,
    this.eliminatedDate,
  });
}
