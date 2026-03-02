import 'poem.dart';

class PoemData {
  PoemData({
    required this.poems,
    required this.pageNumber,
    required this.pageSize,
    required this.totalAvailable,
  });

  List<Poem> poems;
  int pageNumber;
  int pageSize;
  int totalAvailable;
}
