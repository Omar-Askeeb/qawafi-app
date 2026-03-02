import 'dart:isolate';

import 'poetic_verse.dart';

class LibyanTitle {
  String libyanTitlesId;
  String title;
  String description;
  List<PoeticVerse> poeticVerses;
  bool isFree;
  bool isDisabled;
  DateTime created;

  LibyanTitle({
    required this.libyanTitlesId,
    required this.title,
    required this.description,
    required this.poeticVerses,
    required this.isDisabled,
    required this.isFree,
    required this.created,
  });
}
