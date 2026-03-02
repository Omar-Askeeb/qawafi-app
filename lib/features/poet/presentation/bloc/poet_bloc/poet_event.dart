part of 'poet_bloc.dart';

@immutable
sealed class PoetEvent {}

final class PoetGetPoets extends PoetEvent {
  final String? query;
  final int pageNo;
  final int PageSize;

  PoetGetPoets({
    required this.query,
    required this.pageNo,
    this.PageSize = 10,
  });
}

final class PoetGoToDetails extends PoetEvent {
  final String poetId;

  PoetGoToDetails({required this.poetId});
}

final class PoetFollow extends PoetEvent {
  final String poetId;

  PoetFollow({required this.poetId});
}

final class PoetUnFollow extends PoetEvent {
  final String poetId;

  PoetUnFollow({required this.poetId});
}

final class PoetGetPoems extends PoetEvent {
  final String poetId;

  PoetGetPoems({required this.poetId});
}

final class PoetNavigateBack extends PoetEvent {}
