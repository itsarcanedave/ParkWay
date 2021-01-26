import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkway/home.dart';
import 'package:parkway/markers.dart';
import 'package:parkway/reserve.dart';

void main() => runApp(MapPage());

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng _location = const LatLng(-6.194996078447994, 106.82303911634862);

  GoogleMapController mapController;

  void _myMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getCurrentLocation() async {
    final Position position = await Geolocator()
        .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        )
        .catchError((err) => print(err));
    CameraPosition(target: _location, zoom: 15.0);

    final CameraPosition MyLocation = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      bearing: 0.0,
      tilt: 0.0,
      zoom: 16.0,
    );

    setState(() async {
      final GoogleMapController controller = await mapController;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(MyLocation),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                ),
              ),
              actions: <Widget>[
                //IconButton(
                //icon: Icon(Icons.gps_fixed_rounded, color: Colors.white),
                //onPressed: () {
                //myLocationEnabled: true;
                //getCurrentLocation();

                //},
                //),
              ],
              title: Text('Available Locations')),
          body: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            trafficEnabled: true,
            markers: {
              GrandIndonesia,
              SudirmanPlaza,
              CityTower,
              PlazaSenayan,
              SenayanCity,
              PacificPlace,
              PlazaSemanggi,
              Sarinah,
              PlazaIndonesia,
              RitzCarlton,
              //LippoThamrin,
              //ThamrinCity,
              //PlazaFestival,
              //RasunaEpicentrum,
              //SenayanPark,
              //BNI46,
              Citywalk,
              //MRT,
              //Sahid,
              //WismaNusantara,
              //Balaikota,
              //USA,
              Gambir,
              Kokas
            },
            onMapCreated: _myMapCreated,
            initialCameraPosition:
                CameraPosition(target: _location, zoom: 15.0),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text('Park'),
            icon: Icon(Icons.local_parking_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReserveList()),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat),
    );
  }
}
