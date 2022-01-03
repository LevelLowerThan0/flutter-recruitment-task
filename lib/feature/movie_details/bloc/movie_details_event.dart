import 'package:equatable/equatable.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovie extends MovieDetailsEvent {}

class LoadingMovie extends MovieDetailsEvent {}

class LoadedMovie extends MovieDetailsEvent {}

class ShowMovie extends MovieDetailsEvent {}

class DeleteMovie extends MovieDetailsEvent {
  final movie;

  DeleteMovie({required this.movie}) : super();
}
