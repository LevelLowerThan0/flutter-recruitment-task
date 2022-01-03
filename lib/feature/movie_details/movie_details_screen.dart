import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movie_details/widgets/movie_actions.dart';
import 'package:filmguru/feature/movie_details/widgets/movie_details.dart';
import 'package:filmguru/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/movie_details_bloc.dart';
import 'bloc/movie_details_event.dart';
import 'bloc/movie_details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final BuildContext context;
  final List<MovieItem> moviesList;
  final int index;
  const MovieDetailsScreen(
      {Key? key,
      required this.context,
      required this.moviesList,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).mainAppBarTitle),
        ),
        body: BlocProvider(
          create: (context) => MovieDetailsBloc(
              movie: moviesList[index], moviesList: moviesList),
          child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieLoaded || state is ShowMovie) {
                return MovieDetails(moviesList, index);
              } else if (state is NoMovie) {
                context.read<MovieDetailsBloc>().add(LoadMovie());
                return Text(S.of(context).errorNoMovie);
              } else {
                return Text(S.of(context).errorNoData);
              }
            },
          ),
        ),
        floatingActionButton: MovieActions(context, moviesList, index));
  }
}
