import 'dart:convert';

import 'package:flutter_ecommerc/src/constant/token/map_api.dart';
import 'package:flutter_ecommerc/src/constant/utils/url.dart';
import 'package:flutter_ecommerc/src/data/model/map_data.dart';
import 'package:http/http.dart' as http;

class MapProvider {
  MapApi mapApi = MapApi();
  Future<List<MapData>> getMap() async {
    try {
      final response = await http.get(
        Uri.parse(
            "${APPURL.MapUrl}/getOwnedNearby?lat=${mapApi.lat}&lon=${mapApi.lon}&apiKey=${mapApi.ApiKey}&type=${mapApi.type}&detailLevel=${mapApi.detailLevel}"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        List<dynamic> data = responseData['data'];
        print('mapresponse:$data');
        return data.map((json) => MapData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
