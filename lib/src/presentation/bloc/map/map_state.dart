import 'package:flutter_ecommerc/src/data/model/map_data.dart';

class MapState {}

class MapInitialState extends MapState {}

class MapLoadingState extends MapState {}

class MapStateSuccess extends MapState {
  List<MapData> response;
  MapStateSuccess(this.response);
}

class MapStateFailed extends MapState {
  final Message;
  MapStateFailed(this.Message);
}
