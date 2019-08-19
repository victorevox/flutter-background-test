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
    // TODO: implement load
    if(this.db.database == null) {
      return Future.any(List.from([]));
    }
    List maps = await this.db.load();
    return maps.map((map) => LocationEntity.fromMap(map));
  }

  @override
  Future insert(LocationEntity location) {
    if(this.db.database == null) {return Future.any(null);}
    return this.db.insert(location);
  }

}