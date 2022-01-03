import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:filmguru/repository/movies_repository.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final MoviesRepository moviesRepository;

  MoviesListBloc({required this.moviesRepository}) : super(InitialState());

  @override
  Stream<MoviesListState> mapEventToState(MoviesListEvent event) async* {
    if (event is FetchMoviesStarted) {
      yield LoadingState();
      var movies = await moviesRepository.getMovies();
      if (movies.isEmpty || movies.length == 0) {
        yield EmptyList();
      } else {
        yield ListLoaded(movies);
      }
    } else if (event is UpdateMovies) {
      yield LoadingState();
      yield ListLoaded(event.moviesList);
    }
  }

  log(event, state) {
    print('\n[STATE] : $state');
    print('[EVENT] : $event');
    print('-------------------------------------------------\n');
  }

  wait(int duration) async {
    for (int i = 0; i < duration; i++) {
      print('[ <<<Sleep>>>\t${(i + 1)} seconds ]');
      await Future.delayed(Duration(seconds: duration));
    }
  }
}
