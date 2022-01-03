import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_item_row.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (context, state) {
        return ListView.builder(
            key: ValueKey('listV'),
            itemCount: state.moviesList.length,
            itemBuilder: (context, index) =>
                MovieItemRow(state.moviesList, index));
      },
    );
  }
}
