part of 'popularProverbs_bloc.dart';

abstract class PopularProverbsEvent {
  const PopularProverbsEvent();
}

class GetPopularProverbsByAlpha extends PopularProverbsEvent{
  final String Alpha ;
  GetPopularProverbsByAlpha({required this.Alpha,});
}

class RefreshPopularProverbsByAlbpa extends PopularProverbsEvent{
  final String Alpha ;
  RefreshPopularProverbsByAlbpa({required this.Alpha});
}