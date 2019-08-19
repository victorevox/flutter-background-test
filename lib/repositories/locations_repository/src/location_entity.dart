class LocationEntity {
  final String id;
  final double lat;
  final double lng;

  LocationEntity({this.id, this.lat, this.lng});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "lat": this.lat,
      "lng": this.lng
    };
  }

  static LocationEntity fromMap(dynamic map) {
    return LocationEntity(
      id: map["id"],
      lat: map["lat"],
      lng: map["lng"]
    );
  }
}