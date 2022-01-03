import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movie_details/movie_details_screen.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_state.dart';
import 'package:filmguru/theme/app_colors.dart';
import 'package:filmguru/theme/app_dimensions.dart';
import 'package:filmguru/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_dimensions.dart';

class MovieItemRow extends StatelessWidget {
  MovieItemRow(this._movies, this.index);
  final List<MovieItem> _movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) => Container(
        height: AppDimensions.movieListItemPosterHeight,
        child: BlocBuilder<DisplayListBloc, DisplayListState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _navigationToMovieDetail(context, index);
              },
              child: Stack(
                children: <Widget>[
                  _poster(),
                  _title(context),
                ],
              ),
            );
          },
        ),
      );

  Image _poster() => Image.network(
        _movies[index].poster,
        fit: BoxFit.fitWidth,
        width: double.infinity,
      );

  Align _title(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: AppColors.transparentBlack,
          padding: const EdgeInsets.all(AppDimensions.spacingNormal),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  child: Text(
                    _movies[index].title,
                    overflow: TextOverflow.ellipsis,
                    style:
                        AppTextStyles.title().copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _navigationToMovieDetail(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(
            context: context, moviesList: _movies, index: index),
      ),
    );
  }
}
