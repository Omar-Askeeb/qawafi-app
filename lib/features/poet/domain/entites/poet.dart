class Poet {
  final String poetId;
  final String fullName;
  final String phoneNumber;
  final bool isPassedAway;
  final String gender;
  final int followers;
  final int numberOfPoem;
  final bool isDisabled;
  final String city;
  final String imageSrc;
  final DateTime created;
  final DateTime lastModified;

  Poet({
    required this.poetId,
    required this.fullName,
    required this.phoneNumber,
    required this.isPassedAway,
    required this.gender,
    required this.followers,
    required this.numberOfPoem,
    required this.isDisabled,
    required this.city,
    required this.imageSrc,
    required this.created,
    required this.lastModified,
  });
}
