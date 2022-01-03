import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:filmguru/feature/movies_list/views/movies_grid/widgets/movie_item_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (context, state) {
        return Container(
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(state.moviesList.length,
                  (index) => MovieItemGrid(state.moviesList, index))),
        );
      },
    );
  }
}
