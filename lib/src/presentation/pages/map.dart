import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerc/src/data/model/map_data.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/map/map_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/map/map_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/map/map_state.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Set<Marker> _markers = {};
  // LatLng? currentLocation;
  late MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    BlocProvider.of<MapBloc>(context).add(GetMapEvent());
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        _getUserLocation();
      } else {
        print('Location permission denied.');
      }
    } else {
      _getUserLocation();
    }
  }

  Future<void> _getUserLocation() async {
    try {
      // LocationSettings locationSettings =
      //     LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0);
      // Position position = await Geolocator.getCurrentPosition(
      //   locationSettings: locationSettings,
      // );
      // setState(() {
      //   currentLocation = LatLng(position.latitude, position.longitude);
      // });
      // setState(() {
      //   LatLng location = LatLng(9.015763, 38.774114);
      // });
      // print("current Location:$currentLocation");
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void _setMarkers(List<MapData> locationData) {
    locationData.map((locationPoint) {
      double latitude = double.parse(locationPoint.latitude);
      double longtiud = double.parse(locationPoint.longitude);
      LatLng locations = LatLng(latitude, longtiud);
      _markers.add(Marker(
          width: 100,
          height: 100,
          point: locations,
          child: Builder(
            builder: (context) => Container(
              child: Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 40,
              ),
            ),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng location = LatLng(9.015763, 38.774114);
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: const Text("Map"),
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          if (state is MapLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MapStateFailed) {
            return Center(
                child:
                    Text(state.Message, style: TextStyle(color: Colors.red)));
          } else if (state is MapStateSuccess) {
            final locationData = state.response;
            _setMarkers(locationData);
            return Stack(children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight / 2,
                    child: Positioned.fill(
                      child: FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            maxZoom: 13.0,
                            onMapReady: () {
                              // Only set center when currentLocation is available
                              // if (location != null) {
                              // Here you might want to move the camera programmatically
                              mapController.move(location, 13.0);
                              // }
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: const ['a', 'b', 'c'],
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
                            ),
                            MarkerLayer(markers: _markers.toList()),
                            // MarkerLayer(

                            //         .where((marker) => marker != null)
                            //         .cast<Marker>()
                            //         .toList())
                            // CircleLayer(
                            //   circles: [
                            //     CircleMarker(
                            //         point: location,
                            //         radius: 10,
                            //         useRadiusInMeter: true,
                            //         color: Colors.blue),
                            //   ],
                            // ),
                          ]),
                    ),
                  );
                },
              ),
              // DraggableScrollableSheet(
              //   initialChildSize: 0.5,
              //   minChildSize: 0.5,
              //   maxChildSize: 1,
              //   builder:
              //       (BuildContext context, ScrollController scrollController) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius:
              //             BorderRadius.vertical(top: Radius.circular(20)),
              //       ),
              //       child: Column(
              //         children: [
              //           Icon(
              //             Icons.drag_handle,
              //             size: 25,
              //           ),
              //           ListView.builder(
              //             controller: scrollController,
              //             itemCount: state.response.length,
              //             itemBuilder: (context, index) {
              //               final mapItems = state.response[index];
              //               final distance = mapItems.distance / 1000;
              //               String distanceInKilloMeter =
              //                   distance.toStringAsFixed(2);
              //               int minutes =
              //                   ((mapItems.duration % 3600) / 60).floor();

              //               return Container(
              //                 height: 70,
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   border: Border.all(
              //                     color: Colors.blue,
              //                     width: 3,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 margin: EdgeInsets.all(15),
              //                 child: Column(
              //                   children: [
              //                     Text(mapItems.name),
              //                     Text("${distanceInKilloMeter}Km"),
              //                     Text("${minutes}min"),
              //                   ],
              //                 ),
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // )
            ]);
          }
          return Center(child: Text("No map available."));
        }));
  }
}
