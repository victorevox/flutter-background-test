import 'package:background_location_flutter/models/location.dart';
import 'package:background_location_flutter/repositories/locations_repository/src/location_entity.dart';
import 'package:background_location_flutter/repositories/locations_repository_flutter/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<Location> _locations = List.from([]);
  LocationsRepositoryFlutter _locationsRepositoryFlutter;

  void _incrementCounter() async {
    List<LocationEntity> locations =
        await this._locationsRepositoryFlutter.load();
    this._locations = locations.map((l) => Location.fromEntity(l)).toList();

    int count = await this._locationsRepositoryFlutter.count();

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _counter = count;
    });
  }

  @override
  void initState() {
    super.initState();

    // Create a Dog and add it to the dogs table.
    // final newLocation = Location(
    //   id: 0,
    //   lat: 10,
    //   lng: 35,
    // );

    this._locationsRepositoryFlutter = LocationsRepositoryFlutter();

    ////
    // 1.  Listen to events (See docs for all 12 available events).
    //

    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print('[location] - $location');
      this._locationsRepositoryFlutter.insert(Location(
            lat: location.coords.latitude,
            lng: location.coords.longitude,
            id: location.uuid,
            time: DateTime.parse(location.timestamp),
            speed: location.coords.speed,
          ).toEntity());
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    // Timer(new Duration(seconds: 1), () async {
    //   List<LocationEntity> locations =
    //       await this._locationsRepositoryFlutter.load();
    //   print(locations);
    // });

    ////
    ///
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
      debug: true,
      stopOnStationary: false,
      preventSuspend: true,
      logLevel: bg.Config.LOG_LEVEL_VERBOSE,
      reset: true,
    )).then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    const int resultsToShow = 50;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text('Showing last $resultsToShow results: ')
                ],
              ),
              Container(
                height: 350,
                width: double.infinity,
                child: ListView(
                  children: this
                      ._locations
                      .reversed
                      .take(resultsToShow)
                      .map((location) => ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(location.id),
                            subtitle: Text(location.lat.toString() +
                                ', ' +
                                location.lng.toString() + ' | ' + location.speed.toString() + ' + ' + location.timestamp),
                          ))
                      .toList(),
                ),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
