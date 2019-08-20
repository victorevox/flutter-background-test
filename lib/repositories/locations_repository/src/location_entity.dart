class LocationEntity {
  final String id;
  final double lat;
  final double lng;
  final double speed;
  final int time;

  LocationEntity({this.id, this.lat, this.lng, this.speed, this.time});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "lat": this.lat,
      "lng": this.lng,
      "speed": this.speed,
      "time": this.time
    };
  }

  static LocationEntity fromMap(dynamic map) {
    return LocationEntity(
      id: map["id"],
      lat: map["lat"],
      lng: map["lng"],
      speed: map["speed"],
      time: map["time"]
    );
  }
}