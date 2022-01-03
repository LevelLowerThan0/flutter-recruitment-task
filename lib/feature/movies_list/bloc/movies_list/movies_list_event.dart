abstract class MoviesListEvent {
  const MoviesListEvent();
}

class FetchMoviesStarted extends MoviesListEvent {}

class FetchMoviesInProgress extends MoviesListEvent {}

class FetchMoviesDone extends MoviesListEvent {}

class UpdateMovies extends MoviesListEvent {
  var moviesList;

  UpdateMovies({required this.moviesList}) : super();
}
