class DBLocation {
  final String lat;
  final String long;
  final bool outOfSafeZone;
  final bool alarm;

  const DBLocation({
    required this.lat,
    required this.long,
    required this.outOfSafeZone,
    required this.alarm,
  });

  factory DBLocation.fromJson(Map<String, dynamic> json) {
    return DBLocation(
      lat: json["lat"],
      long: json["long"],
      outOfSafeZone: json["outOfSafeZone"],
      alarm: json["alarm"],
    );
  }
}
