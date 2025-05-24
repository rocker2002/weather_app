class Location{
  final String name;
  final String countryName;
  final double lat;
  final double lng;

  Location({required this.name, required this.countryName, required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
    countryName: json['countryName'],
    lat: double.parse(json['lat'].toString()),
    lng: double.parse(json['lng'].toString())
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'countryName': countryName, 'lat': lat, 'lng': lng};
}