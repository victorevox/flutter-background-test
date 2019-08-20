import 'dart:async';

import 'package:background_location_flutter/repositories/locations_repository/src/location_entity.dart';

abstract class LocationsRepository {
  // void Function(String token) setClientAuthenticationToken(token);
  // void Function(String domain) setClientDomain(domain);

  Future<List<LocationEntity>> load();
  Future insert(LocationEntity location);
  Future<int> count();
  // Future<void> clearAll();
  // Future<void> clearCells(
  //   List<String> cellsLetter
  // );
}
