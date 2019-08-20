import 'package:background_location_flutter/repositories/locations_repository/src/location_entity.dart';
import 'package:flutter/cupertino.dart';

class Location {
  final String id;
  final double lat;
  final double lng;
  final double speed;
  final DateTime time;

  Location({this.id, this.lat, this.lng, @required this.time, @required this.speed});

  Location copyWith({
    String id,
    double lat,
    double lng,
    double speed,
    DateTime time,
  }) {
    return Location(
      id: id?? this.id,
      lat: lat?? this.lat,
      lng: lng?? this.lng,
      speed: speed?? this.speed,
      time: time?? this.time
    );
  }

  String get timestamp {
    return  this.time != null? this.time.toIso8601String() : "";
  }

  static Location fromEntity(LocationEntity entity ) {
    return Location(id: entity.id?? 0, lat: entity.lat?? 0, lng: entity.lng?? 0, speed: entity.speed, time: DateTime.fromMillisecondsSinceEpoch(entity.time));
  }

  LocationEntity toEntity() {
    return LocationEntity(id: this.id, lat: this.lat, lng: this.lng, speed: this.speed, time: this.time != null? this.time.millisecondsSinceEpoch : null);
  }

  Map<String, dynamic> toMap() {
    return this.toEntity().toMap();
  }
}