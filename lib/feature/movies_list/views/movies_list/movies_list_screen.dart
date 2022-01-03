import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:filmguru/feature/movies_list/views/movies_list/widgets/movies_list.dart';
import 'package:filmguru/generated/l10n.dart';
import 'package:filmguru/theme/app_colors.dart';
import 'package:filmguru/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/keys.dart' as Keys;
import '../../bloc/display_list/display_list_bloc.dart';
import '../../bloc/display_list/display_list_event.dart';
import '../../bloc/display_list/display_list_state.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).mainAppBarTitle),
      ),
      body: Material(
        child: Column(
          children: [
            Container(
              child: BlocBuilder<MoviesListBloc, MoviesListState>(
                builder: (context, state) {
                  if (state is InitialState) {
                    return _startHeaderScreen(context);
                  } else if (state is LoadingState) {
                    return Center(
                      heightFactor: 10,
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ListLoaded) {
                    return Expanded(
                      child: MoviesList(),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<MoviesListBloc, MoviesListState>(
        builder: (context, state) {
          if (state is ListLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                BlocBuilder<DisplayListBloc, DisplayListState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      key: ValueKey(Keys.grid_view_button_key),
                      onPressed: () =>
                          context.read<DisplayListBloc>().add(ShowGrid()),
                      child: const Icon(Icons.grid_3x3),
                    );
                  },
                ),
              ],
            );
          } else {
            return Text(S.of(context).codeclusive);
          }
        },
      ),
    );
  }

  _startHeaderScreen(BuildContext context) {
    return Center(
      heightFactor: 2,
      child: Column(
        children: [
          Text(S.of(context).mainAppBarTitle,
              style: AppTextStyles.title().copyWith(color: Colors.black)),
          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 32),
            height: 96,
            width: 96,
            child: FittedBox(
              fit: BoxFit.cover,
              child: ImageIcon(
                AssetImage('assets/icons/film-reel.png'),
              ),
            ),
          ),
          _startScreen(context),
        ],
      ),
    );
  }

  _startScreen(BuildContext context) {
    return OutlinedButton(
      key: ValueKey(Keys.start_button_key),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.accentColorDark,
      ),
      onPressed: () => {
        context.read<MoviesListBloc>().add(FetchMoviesStarted()),
      },
      child: Text(
        S.of(context).getStarted,
        style: TextStyle(fontSize: 20.0, color: AppColors.white),
      ),
    );
  }
}
