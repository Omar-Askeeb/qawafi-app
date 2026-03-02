part of 'web_view_bloc_bloc.dart';

@immutable
sealed class WebViewBlocEvent {}

final class WebViewBlocSubDoneEvent extends WebViewBlocEvent {
  final String message;

  WebViewBlocSubDoneEvent({required this.message});
}
