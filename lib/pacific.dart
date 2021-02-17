import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkway/home.dart';
import 'package:parkway/pacificres.dart';
import 'dart:math' show cos, sqrt, asin;

class Pacific extends StatefulWidget {
  @override
  PacificState createState() {
    return new PacificState();
  }
}

String place = "Pacific Place";

class PacificState extends State<Pacific> {
  final DocumentReference placeReference =
      FirebaseFirestore.instance.doc("Places" + "/" + place);
  var dummyparking;
  var dummyvalet;

  void _getBalance() {
    placeReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          dummyparking = datasnapshot.data()['space'];
          dummyvalet = datasnapshot.data()['quota'];
        });
      }
    });
  }

  void getPostsData() async {
    final Position position = await Geolocator()
        .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        )
        .catchError((err) => print(err));
    var currPos = position;
    getCurrentLocation();
    double calculateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    double cityTowerDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.19910844638473, 106.82351935077837);
    String cityTower = cityTowerDistance.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getBalance();
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pacific Place"),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/pp.jpg",
                      width: 100,
                    ),
                    Text(
                      "  ",
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Pacific Place\n",
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: <Widget>[],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "  ",
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Jalan Jendral Sudirman 52-53",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Senayan",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "South Jakarta\n",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    //Text(
                    // "from you",
                    //style: const TextStyle(
                    //fontSize: 16,),
                    //),
                    Text(
                      "  ",
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[],
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 0.0,
                        ),
                      ),
                      child: new TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 5.0),
                          ),
                          hintText: dummyparking.toString(),
                          hintStyle: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontFamily: 'Raleway'),
                          prefixIcon: Icon(Icons.local_parking_rounded,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 0.0,
                        ),
                      ),
                      child: new TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 5.0),
                          ),
                          hintText: dummyvalet.toString(),
                          hintStyle: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontFamily: 'Raleway'),
                          prefixIcon: Icon(Icons.drive_eta_rounded,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "",
                      ),
                      onPressed: () {},
                    ),
                    new RaisedButton.icon(
                      onPressed: () {
                        // _signIn();
                        //if(user != null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PacificRes()),
                        );
                      },

                      //Timer(Duration(seconds: 5), () =>
                      //);
                      //},
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      label: Text(
                        'RESERVE',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.local_parking_rounded,
                        color: Colors.blue,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.blue,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
