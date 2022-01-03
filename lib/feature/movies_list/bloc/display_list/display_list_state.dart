import 'package:equatable/equatable.dart';

abstract class DisplayListState extends Equatable {
  final isGrid;
  final movie;

  const DisplayListState({this.movie, this.isGrid = false});

  @override
  List<Object?> get props => [isGrid];
}

class DisplayGrid extends DisplayListState {
  const DisplayGrid() : super(isGrid: true);
}

class DisplayList extends DisplayListState {
  const DisplayList() : super(isGrid: false);
}

class Error extends DisplayListState {
  final String? error;

  Error({this.error});
}
