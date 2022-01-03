import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_event.dart';
import 'package:filmguru/feature/movies_list/bloc/display_list/display_list_state.dart';

class DisplayListBloc extends Bloc<DisplayListEvent, DisplayListState> {
  bool isGrid;
  DisplayListBloc({this.isGrid = false}) : super(DisplayList());

  @override
  Stream<DisplayListState> mapEventToState(DisplayListEvent event) async* {
    if (event is ShowList) {
      yield DisplayList();
    } else {
      yield DisplayGrid();
    }
  }
}
