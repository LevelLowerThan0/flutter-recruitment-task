import 'package:filmguru/feature/movies_list/views/movies_list/movies_list_screen.dart';
import 'package:filmguru/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './data/keys.dart' as Keys;
import 'data/api/movies_service_local.dart';
import 'feature/movies_list/bloc/display_list/display_list_bloc.dart';
import 'feature/movies_list/bloc/display_list/display_list_state.dart';
import 'feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'feature/movies_list/views/movies_grid/movies_list_grid_screen.dart';
import 'generated/l10n.dart';
import 'repository/movies_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MoviesRepository moviesRepository =
      MoviesRepository(MoviesServiceLocal());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MoviesListBloc(moviesRepository: moviesRepository),
        ),
        BlocProvider(
          create: (context) => DisplayListBloc(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: RepositoryProvider(
          create: (context) => MoviesRepository(MoviesServiceLocal()),
          child: BlocBuilder<DisplayListBloc, DisplayListState>(
            builder: (context, state) {
              if (state.isGrid == false)
                return MoviesListScreen(key: ValueKey(Keys.list_view_key));
              else
                return MoviesGridScreen(key: ValueKey(Keys.grid_view_key));
            },
          ),
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
