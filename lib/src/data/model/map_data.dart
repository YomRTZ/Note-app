
class MapData {
  final double duration;
  final double distance;
  final String latitude;
  final String name;
  final String country;
  final String city;
  final String type;
  final String longitude;
  MapData(
      {required this.duration,
      required this.distance,
      required this.latitude,
      required this.name,
      required this.country,
      required this.city,
      required this.type,
      required this.longitude});
  factory MapData.fromJson(Map<String, dynamic> json) {
    return MapData(
        duration: json['duration'],
        distance: json['distance'],
        latitude: json["latitude"],
        name: json["name"],
        country: json["Country"],
        city: json["City"],
        type: json["type"],
        longitude: json["longitude"]);
  }
}
