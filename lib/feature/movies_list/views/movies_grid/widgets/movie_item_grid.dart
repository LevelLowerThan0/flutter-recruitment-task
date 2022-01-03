import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/feature/movie_details/movie_details_screen.dart';
import 'package:filmguru/theme/app_colors.dart';
import 'package:filmguru/theme/app_dimensions.dart';
import 'package:filmguru/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_dimensions.dart';

class MovieItemGrid extends StatelessWidget {
  MovieItemGrid(this._movies, this.index);
  final List<MovieItem> _movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _navigationToMovieDetail(context, index);
          },
          child: _body(context),
        ),
      ],
    );
  }

  Widget _body(BuildContext context) => Container(
        height: AppDimensions.movieListItemPosterHeight,
        child: Stack(
          children: <Widget>[
            _poster(),
            _title(context),
          ],
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
          height: AppDimensions.movieListItemPosterHeight / 4,
          child: Marquee(
            text: _movies[index].title,
            style: AppTextStyles.titleGrid().copyWith(color: AppColors.white),
            velocity: 20,
            pauseAfterRound: Duration(milliseconds: 2000),
            blankSpace: 20,
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
