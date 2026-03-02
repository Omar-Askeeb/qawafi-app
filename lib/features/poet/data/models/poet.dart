class PoetModel {
  final String poetId;
  final String fullName;
  final String phoneNumber;
  final bool isPassedAway;
  final String gender;
  final int followers;
  final int numberOfPoem;
  final bool isDisabled;
  final bool canFollow;
  final String city;
  final String imageSrc;
  final DateTime created;
  final DateTime lastModified;

  PoetModel({
    required this.poetId,
    required this.fullName,
    required this.phoneNumber,
    required this.isPassedAway,
    required this.gender,
    required this.followers,
    required this.numberOfPoem,
    required this.isDisabled,
    required this.canFollow,
    required this.city,
    required this.imageSrc,
    required this.created,
    required this.lastModified,
  });

  factory PoetModel.fromJson(Map<String, dynamic> json) => PoetModel(
        poetId: json["poetId"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        isPassedAway: json["isPassedAway"],
        gender: json["gender"],
        followers: json["followers"],
        numberOfPoem: json["numberOfPoem"] ?? 0,
        isDisabled: json["isDisabled"],
        canFollow: json["canFollow"] ?? false,
        city: json["city"],
        imageSrc: json["imageSrc"],
        created: DateTime.parse(json["created"]),
        lastModified: json["lastModified"] == null
            ? DateTime.now()
            : DateTime.parse(json["lastModified"]),
      );

  Map<String, dynamic> toJson() => {
        "poetId": poetId,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "isPassedAway": isPassedAway,
        "gender": gender,
        "followers": followers,
        "numberOfPoem": numberOfPoem,
        "isDisabled": isDisabled,
        "city": city,
        "imageSrc": imageSrc,
        "created": created.toIso8601String(),
        "lastModified": lastModified.toIso8601String(),
      };
}
