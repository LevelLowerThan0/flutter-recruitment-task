import 'package:bloc_test/bloc_test.dart';
import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:filmguru/feature/movies_list/views/movies_list/movies_list_screen.dart';
import 'package:filmguru/feature/movies_list/views/movies_list/widgets/movie_item_row.dart';
import 'package:filmguru/feature/movies_list/views/movies_list/widgets/movies_list.dart';
import 'package:filmguru/generated/l10n.dart';
import 'package:filmguru/repository/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../lib/data/keys.dart' as Keys;

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

class MockMoviesListBloc extends MockBloc<MoviesListEvent, MoviesListState>
    implements MoviesListBloc {}

class MovieListStateFake extends Fake implements MoviesListState {}

class MovieListEventFake extends Fake implements MoviesListEvent {}

@GenerateMocks([MockMoviesRepository, MockMoviesListBloc])
void main() {
  MockMoviesRepository mockMoviesRepository = MockMoviesRepository();

  registerFallbackValue(MovieListStateFake());
  registerFallbackValue(MovieListEventFake());
  MockMoviesListBloc moviesListBloc = MockMoviesListBloc();

  final List<MovieItem> movies = [
    MovieItem(
        title: 'The Godfather',
        poster:
            'https://image.tmdb.org/t/p/w500/iVZ3JAcAjmguGPnRNfWFOtLHOuY.jpg'),
    MovieItem(
        title: 'The Godfather: Part II',
        poster:
            'https://image.tmdb.org/t/p/w500/amvmeQWheahG3StKwIE1f7jRnkZ.jpg')
  ];

  Widget _homePageWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: MultiBlocProvider(
      providers: [
        BlocProvider<MoviesListBloc>(
          create: (context) => moviesListBloc,
        ),
        BlocProvider<DisplayListBloc>(
          create: (context) => DisplayListBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Widget Test',
        home: Scaffold(body: MoviesListScreen()),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    ),
  );

  testWidgets('Home Page tests', (tester) async {
    mockMoviesRepository.setMovies(movies);

    when(() => moviesListBloc.state).thenReturn(InitialState());

    await tester.pumpWidget(_homePageWidget);
    await tester.pumpAndSettle();

    var titleFinder = find.text('Filmguru');
    var buttonFinder = find.byKey(Key(Keys.start_button_key));

    expect(titleFinder, findsWidgets);
    expect(buttonFinder, findsWidgets);
  });

  testWidgets('List Page tests', (tester) async {
    await mockNetworkImages(() async {
      mockMoviesRepository.setMovies(movies);
      when(() => moviesListBloc.state).thenReturn(ListLoaded(movies));

      await tester.pumpAndSettle();
      await tester.pumpWidget(_homePageWidget);
      await tester.pumpAndSettle();

      var listFinder = find.byType(MoviesList);
      var listViewFinder = find.byType(ListView);
      var listItemFinder = find.byType(MovieItemRow);

      expect(listFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
      expect(listItemFinder, findsNWidgets(2));
    });
  });

  testWidgets('List Page tests', (tester) async {
    await mockNetworkImages(() async {
      mockMoviesRepository.setMovies(movies);
      when(() => moviesListBloc.state).thenReturn(ListLoaded(movies));

      await tester.pumpAndSettle();
      await tester.pumpWidget(_homePageWidget);
      await tester.pumpAndSettle();

      var listFinder = find.byType(MoviesList);
      var listViewFinder = find.byType(ListView);
      var listItemFinder = find.byType(MovieItemRow);

      expect(listFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
      expect(listItemFinder, findsNWidgets(2));
    });
  });
}

log(String title, String message) {
  print('\n^---------------------------------^');
  print(title);
  print('\t\t$message');
  print('^---------------------------------^\n');
}
