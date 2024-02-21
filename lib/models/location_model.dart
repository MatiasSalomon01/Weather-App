// ignore_for_file: non_constant_identifier_names

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tz_id;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tz_id,
    required this.localtime,
  });

  static Location empty() {
    return Location(
      name: "",
      region: "",
      country: "",
      lat: 0,
      lon: 0,
      tz_id: "",
      localtime: "",
    );
  }

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      name: map['name'],
      region: map['region'],
      country: map['country'],
      lat: map['lat'],
      lon: map['lon'],
      tz_id: map['tz_id'],
      localtime: map['localtime'],
    );
  }
}
