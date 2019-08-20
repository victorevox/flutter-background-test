import 'dart:async';

import 'package:background_location_flutter/repositories/locations_repository/location_repository.dart';
import 'package:background_location_flutter/repositories/locations_repository_flutter/src/db.dart';

class LocationsRepositoryFlutter implements LocationsRepository {

  LocationsDb db;

  LocationsRepositoryFlutter() {
    LocationsDb.createDatabase().then((db){
      this.db = db;
    });
  }
  
  @override
  Future<List<LocationEntity>> load() async {
    if(this.db == null) {
      return Future.value(List.from([]));
    }
    List maps = await this.db.load();
    return maps.map((map) => LocationEntity.fromMap(map)).toList();
  }

  @override
  Future insert(LocationEntity location) {
    if(this.db == null) {return Future.value(null);}
    return this.db.insert(location);
  }

  @override
  Future<int> count() async {
    if(this.db == null) {return Future.value(null);}
    int count = await this.db.count();
    return count;
  }

}