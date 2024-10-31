import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerc/src/data/domain/map_repository.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/map/map_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/map/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository;

  MapBloc({required this.mapRepository}) : super(MapInitialState()) {
    on<GetMapEvent>((event, emit) async {
      emit(MapLoadingState());
      try {
        final response = await mapRepository.mapRepo();
        print("object $response");
        if (response.isNotEmpty) {
          emit(MapStateSuccess(response));
        }
      } catch (e) {
        emit(MapStateFailed("Failed to fetch posts. ${e.toString()}"));
      }
    });
  }
}
