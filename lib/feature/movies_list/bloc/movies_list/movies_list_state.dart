import 'package:equatable/equatable.dart';
import 'package:filmguru/data/model/movie_item.dart';

class MoviesListState extends Equatable {
  final List<MovieItem> moviesList;
  const MoviesListState({this.moviesList = const []});

  @override
  List<Object?> get props => [moviesList];
}

class InitialState extends MoviesListState {}

class EmptyList extends MoviesListState {}

class LoadingState extends MoviesListState {}

class ListLoaded extends MoviesListState {
  const ListLoaded(List<MovieItem> movies) : super(moviesList: movies);
}

class Error extends MoviesListState {
  final String? error;

  Error({this.error});
}
