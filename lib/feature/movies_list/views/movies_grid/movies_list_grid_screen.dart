import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/movies_list/movies_list_state.dart';
import 'package:filmguru/feature/movies_list/views/movies_grid/widgets/movies_grid.dart';
import 'package:filmguru/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/keys.dart' as Keys;
import '../../bloc/display_list/display_list_bloc.dart';
import '../../bloc/display_list/display_list_state.dart';

class MoviesGridScreen extends StatelessWidget {
  const MoviesGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).mainAppBarTitle),
      ),
      body: Column(
        children: [
          Container(
            child: BlocBuilder<MoviesListBloc, MoviesListState>(
              builder: (context, state) {
                if (state is InitialState) {
                  return Center(
                    child: Text(S.of(context).errorNoData),
                  );
                } else if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListLoaded) {
                  return Expanded(
                    child: MoviesGrid(),
                  );
                }
                return Text(S.of(context).errorGeneral);
              },
            ),
          ),
        ],
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
                      key: ValueKey(Keys.list_view_button_key),
                      onPressed: () =>
                          context.read<DisplayListBloc>().add(ShowList()),
                      child: const Icon(Icons.list),
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
}
