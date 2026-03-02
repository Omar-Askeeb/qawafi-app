part of 'libyan_title_bloc.dart';

@immutable
sealed class LibyanTitleEvent {}

final class LibyanTitleFetchEvent extends LibyanTitleEvent {
  final int pageNo;
  final int PageSize;

  LibyanTitleFetchEvent({
    required this.pageNo,
    this.PageSize = 10,
  });
}
