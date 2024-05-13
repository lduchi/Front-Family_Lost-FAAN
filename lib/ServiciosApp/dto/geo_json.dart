class GeoJson {
  final double x;
  final double y;
  final String type;
  final List<double> coordinates;

  GeoJson({
    required this.x,
    required this.y,
    required this.type,
    required this.coordinates,
  });

  factory GeoJson.fromJson(Map<String, dynamic> json) {
    return GeoJson(
      x: json['x'],
      y: json['y'],
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'type': type,
      'coordinates': coordinates,
    };
  }
}