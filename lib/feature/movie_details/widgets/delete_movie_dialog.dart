import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_bloc.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_event.dart';
import 'package:filmguru/feature/movie_details/bloc/movie_details_state.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/keys.dart' as Keys;

class DeleteMovieDialog extends StatelessWidget {
  DeleteMovieDialog(this.context, this.moviesList, this.index);

  final BuildContext context;
  final List<MovieItem> moviesList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        key: ValueKey(Keys.dialog_alert_key),
        title: Text(S.of(context).dialogTitle),
        content: Text(S.of(context).dialogMessage),
        actions: [
          TextButton(
            key: ValueKey(Keys.cancel_button_key),
            onPressed: () => Navigator.pop(context, S.of(context).dialogCancel),
            child: Text(S.of(context).dialogCancel),
          ),
          BlocProvider(
            create: (context) => MovieDetailsBloc(
                movie: moviesList[index],
                moviesList: moviesList,
                moviesListBloc: context.read<MoviesListBloc>()),
            child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, state) {
              return TextButton(
                key: ValueKey(Keys.confirm_button_key),
                child: Text(S.of(context).dialogConfirm),
                onPressed: () {
                  var movieDetailsBloc = context.read<MovieDetailsBloc>();
                  movieDetailsBloc.add(DeleteMovie(movie: moviesList[index]));
                  Navigator.pop(context, S.of(context).dialogConfirm);
                  Navigator.pop(context);
                },
              );
            }),
          ),
        ]);
  }
}
