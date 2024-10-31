
import 'package:flutter_ecommerc/src/data/model/map_data.dart';
import 'package:flutter_ecommerc/src/data/provider/map_provider.dart';

class MapRepository {
  MapProvider mapProvider;
  MapRepository({required this.mapProvider});
  Future<List<MapData>> mapRepo() async {
    return await mapProvider.getMap();
  }
}
