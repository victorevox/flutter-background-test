import 'package:background_location_flutter/repositories/locations_repository/src/location_entity.dart';

class Location {
  final String id;
  final double lat;
  final double lng;

  Location({this.id, this.lat, this.lng});

  Location copyWith({
    String id,
    double lat,
    double lng,
  }) {
    return Location(
      id: id?? this.id,
      lat: lat?? this.lat,
      lng: lng?? this.lng
    );
  }

  static Location fromEntity(LocationEntity entity ) {
    return Location(id: entity.id?? 0, lat: entity.lat?? 0, lng: entity.lng?? 0);
  }

  LocationEntity toEntity() {
    return LocationEntity(id: this.id, lat: this.lat, lng: this.lng);
  }

  Map<String, dynamic> toMap() {
    return this.toEntity().toMap();
  }
}