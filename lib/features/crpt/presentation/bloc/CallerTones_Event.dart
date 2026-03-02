part of 'CallerTones_bloc.dart';

abstract class CallerTonesEvent {
}

class CallerTonesByID extends CallerTonesEvent{
  final String Id ;

  CallerTonesByID({required this.Id});
}

// class RefreshPopularProverbsByAlbpa extends CallerTonesCategoryEvent{
//   final String Alpha ;
//   RefreshPopularProverbsByAlbpa({required this.Alpha});
// }