part of 'CallerTonesCategory_bloc.dart';

abstract class CallerTonesCategoryEvent {
}

class CallerTonesCategoryByAlpha extends CallerTonesCategoryEvent{
  final String alpha ;
  final String gender;
  CallerTonesCategoryByAlpha({required this.alpha,required this.gender});
}

// class RefreshPopularProverbsByAlbpa extends CallerTonesCategoryEvent{
//   final String Alpha ;
//   RefreshPopularProverbsByAlbpa({required this.Alpha});
// }