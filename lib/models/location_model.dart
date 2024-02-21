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
}
