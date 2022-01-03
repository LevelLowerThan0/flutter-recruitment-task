import 'package:equatable/equatable.dart';
import 'package:filmguru/data/model/movie_item.dart';

abstract class MovieDetailsState extends Equatable {
  final bool deleted;
  final MovieItem? movie;
  const MovieDetailsState({this.movie, this.deleted = false});

  @override
  List<Object?> get props => [movie];
}

class InitialState extends MovieDetailsState {}

class MovieLoaded extends MovieDetailsState {
  MovieLoaded(MovieItem movie) : super(movie: movie);
}

class NoMovie extends MovieDetailsState {}

class MovieDeleted extends MovieDetailsState {
  var moviesList;

  MovieDeleted({required this.moviesList}) : super();
}

class Error extends MovieDetailsState {
  final String? error;

  Error({this.error});
}
