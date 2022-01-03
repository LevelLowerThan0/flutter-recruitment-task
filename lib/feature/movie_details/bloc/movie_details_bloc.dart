import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_event.dart';

import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  var movie;
  List<MovieItem> moviesList;
  late MoviesListBloc? moviesListBloc;

  MovieDetailsBloc(
      {required this.movie, required this.moviesList, this.moviesListBloc})
      : super(NoMovie());

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    if (event is LoadMovie) {
      yield MovieLoaded(movie);
    } else if (event is DeleteMovie) {
      moviesList.remove(event.movie);

      // moviesListBloc!.state.moviesList.remove(event.movie);
      moviesListBloc!.add(UpdateMovies(moviesList: moviesList));
      yield MovieDeleted(moviesList: moviesList);
    }
  }
}
