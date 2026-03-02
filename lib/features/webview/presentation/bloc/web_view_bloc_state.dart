part of 'web_view_bloc_bloc.dart';

@immutable
sealed class WebViewBlocState {}

final class WebViewBlocInitial extends WebViewBlocState {}

final class WebViewBlocFailure extends WebViewBlocState {
  final String message;

  WebViewBlocFailure({required this.message});
}

final class WebViewBlocLoading extends WebViewBlocState {}

final class WebViewBlocLoaded extends WebViewBlocState {
  final String message;

  WebViewBlocLoaded({required this.message});
}
