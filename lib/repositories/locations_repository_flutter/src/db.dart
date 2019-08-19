import 'package:background_location_flutter/repositories/locations_repository/location_repository.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class LocationsDb {
  final sql.Database database;

  LocationsDb({this.database});

  static Future<LocationsDb> createDatabase() async {
    // Open the database and store the reference.
    final database = await sql.openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path.join(await sql.getDatabasesPath(), 'location_database.db'),
      // When the database is first created, create a table to store locations.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE locations(id TEXT PRIMARY KEY, lat DOUBLE, lng DOUBLE)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return LocationsDb(database: database);
  }

  // Define a function that inserts locations into the database
  Future<void> insert(LocationEntity location) async {
    // Get a reference to the database.
    // final sql.Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await this.database.insert(
          'locations',
          location.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace,
        );
  }

  Future <List<Map<String, dynamic>> >load() {
    return this.database.query("locations");
  }

}
