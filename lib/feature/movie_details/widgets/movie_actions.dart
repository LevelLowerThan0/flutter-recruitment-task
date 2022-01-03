import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_bloc.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_state.dart';
import 'package:filmguru/feature/movie_details/widgets/delete_movie_dialog.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/keys.dart' as Keys;

class MovieActions extends StatelessWidget {
  MovieActions(this.context, this.moviesList, this.index);

  final BuildContext context;
  final List<MovieItem> moviesList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: ValueKey(Keys.dislike_button_key),
      onPressed: () => {},
      child: BlocProvider(
        create: (context) => MovieDetailsBloc(
            movie: moviesList[index],
            moviesList: moviesList,
            moviesListBloc: context.read<MoviesListBloc>()),
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            return IconButton(
              icon: const Icon(Icons.thumb_down),
              onPressed: () => {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteMovieDialog(context, moviesList, index);
                    })
              },
            );
          },
        ),
      ),
    );
  }
}
