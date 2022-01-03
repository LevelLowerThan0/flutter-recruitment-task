import 'package:filmguru/data/model/movie_item.dart';
import 'package:filmguru/theme/app_dimensions.dart';
import 'package:filmguru/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/keys.dart' as Keys;

class MovieDetails extends StatelessWidget {
  MovieDetails(this.moviesList, this.index);

  final List<MovieItem> moviesList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            moviesList[index].title,
            key: ValueKey(Keys.movie_details_title_key),
            style: AppTextStyles.title(),
            textAlign: TextAlign.center,
          ),
          margin: EdgeInsets.fromLTRB(
              0, AppDimensions.spacingNormal, 0, AppDimensions.spacingNormal),
        ),
        Flexible(
          child: Image.network(
            moviesList[index].poster,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
