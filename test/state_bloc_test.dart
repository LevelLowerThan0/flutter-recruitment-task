import 'package:bloc_test/bloc_test.dart';
import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_bloc.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_event.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_state.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_state.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:filmguru/repository/movies_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {
  List<MovieItem> movies = [];

  setMovies(List<MovieItem> movies) {
    this.movies = movies;
  }

  @override
  Future<List<MovieItem>> getMovies() {
    return Future.value(movies);
  }
}

@GenerateMocks([MockMoviesRepository])
void main() {
  MockMoviesRepository mockMoviesRepository = MockMoviesRepository();
  bool showFailureTests = false;

  // ====> MovieDetailsBloc
  testMovieListBloc(mockMoviesRepository);

  // ====> DisplayListBloc
  testDisplayListBloc();

  // ====> MovieDetailsBloc
  testMovieDetailsBloc(mockMoviesRepository);

  // ====> When failure
  if (showFailureTests == true) {
    failureTests(mockMoviesRepository);
  }
}

void testMovieListBloc(MockMoviesRepository mockMoviesRepository) {
  group('[MoviesList] tests', () {
    final List<MovieItem> movies = [
      MovieItem(
          title: 'The Godfather', poster: '/iVZ3JAcAjmguGPnRNfWFOtLHOuY.jpg'),
      MovieItem(
          title: 'The Godfather: Part II',
          poster: '/amvmeQWheahG3StKwIE1f7jRnkZ.jpg')
    ];

    mockMoviesRepository.setMovies(movies);

    blocTest<MoviesListBloc, MoviesListState>(
      'emits [LoadingState, ListLoaded] when successful',
      build: () {
        mockMoviesRepository.setMovies(movies);
        return MoviesListBloc(moviesRepository: mockMoviesRepository);
      },
      act: (MoviesListBloc bloc) => {
        bloc.add(FetchMoviesStarted()),
      },
      expect: () => [
        LoadingState(),
        ListLoaded(movies),
      ],
    );

    final List<MovieItem> emptyList = [];

    blocTest<MoviesListBloc, MoviesListState>(
      'emits [LoadingState, EmptyList] when successful',
      build: () {
        mockMoviesRepository.setMovies(emptyList);
        return MoviesListBloc(moviesRepository: mockMoviesRepository);
      },
      act: (MoviesListBloc bloc) => {
        bloc.add(FetchMoviesStarted()),
      },
      expect: () => [
        LoadingState(),
        EmptyList(),
      ],
    );
  });
}

void testMovieDetailsBloc(MockMoviesRepository mockMoviesRepository) {
  group('[MoviesDetails] tests', () {
    final List<MovieItem> movies = [
      MovieItem(
          title: 'The Godfather', poster: '/iVZ3JAcAjmguGPnRNfWFOtLHOuY.jpg'),
      MovieItem(
          title: 'The Godfather: Part II',
          poster: '/amvmeQWheahG3StKwIE1f7jRnkZ.jpg')
    ];

    mockMoviesRepository.setMovies(movies);

    blocTest<MovieDetailsBloc, MovieDetailsState>(
      'emits [MovieLoaded] when successful',
      build: () {
        mockMoviesRepository.setMovies(movies);
        return MovieDetailsBloc(movie: movies[0], moviesList: movies);
      },
      act: (MovieDetailsBloc bloc) => {
        bloc.add(LoadMovie()),
      },
      expect: () => [MovieLoaded(movies[0])],
    );

    blocTest<MovieDetailsBloc, MovieDetailsState>(
      'emits [MovieDeleted] when successful',
      build: () {
        mockMoviesRepository.setMovies(movies);
        return MovieDetailsBloc(
            movie: movies[0],
            moviesList: movies,
            moviesListBloc:
                MoviesListBloc(moviesRepository: mockMoviesRepository));
      },
      act: (MovieDetailsBloc bloc) => {
        bloc.add(DeleteMovie(movie: movies[0])),
      },
      expect: () => [
        MovieDeleted(moviesList: movies),
      ],
    );
  });
}

void testDisplayListBloc() {
  group('[DisplayList] tests', () {
    blocTest<DisplayListBloc, DisplayListState>(
      'emits [DisplayList] when successful',
      build: () {
        return DisplayListBloc();
      },
      act: (DisplayListBloc bloc) => {
        bloc.add(ShowList()),
      },
      expect: () => [
        DisplayList(),
      ],
    );

    blocTest<DisplayListBloc, DisplayListState>(
      'emits [DisplayGrid] when successful',
      build: () {
        return DisplayListBloc();
      },
      act: (DisplayListBloc bloc) => {
        bloc.add(ShowGrid()),
      },
      expect: () => [
        DisplayGrid(),
      ],
    );
  });
}

void failureTests(MockMoviesRepository mockMoviesRepository) {
  final List<MovieItem> movies = [
    MovieItem(
        title: 'The Godfather', poster: '/iVZ3JAcAjmguGPnRNfWFOtLHOuY.jpg'),
    MovieItem(
        title: 'The Godfather: Part II',
        poster: '/amvmeQWheahG3StKwIE1f7jRnkZ.jpg')
  ];

  group('[Failure] tests', () {
    blocTest<MovieDetailsBloc, MovieDetailsState>(
      'emits [MovieLoaded] when wrong movie',
      build: () {
        mockMoviesRepository.setMovies(movies);
        return MovieDetailsBloc(movie: movies[0], moviesList: movies);
      },
      act: (MovieDetailsBloc bloc) => {
        bloc.add(LoadMovie()),
      },
      expect: () => [MovieLoaded(movies[1])],
    );

    blocTest<MoviesListBloc, MoviesListState>(
      'emits [LoadingState, EmptyList] when wrong data',
      build: () {
        return MoviesListBloc(moviesRepository: mockMoviesRepository);
      },
      act: (MoviesListBloc bloc) => {
        bloc.add(FetchMoviesStarted()),
      },
      expect: () => [
        LoadingState(),
        ListLoaded([]),
      ],
    );
  });
}
