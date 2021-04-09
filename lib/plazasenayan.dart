import 'dart:math' show cos, sqrt, asin;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkway/home.dart';
import 'package:parkway/plazasenayanres.dart';
import 'package:parkway/reserve.dart';

class PlazaSenayan extends StatefulWidget {
  @override
  PlazaSenayanState createState() {
    return new PlazaSenayanState();
  }
}

String place = "Plaza Senayan";

class PlazaSenayanState extends State<PlazaSenayan> {
  final DocumentReference placeReference =
      FirebaseFirestore.instance.doc("Places" + "/" + place);
  var dummyparking;
  var dummyvalet;
  String service1;
  String service2;
  String service3;

  void _getBalance() {
    placeReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          dummyparking = datasnapshot.data()['space'];
          dummyvalet = datasnapshot.data()['quota'];
          service1 = datasnapshot.data()['service1'];
          service2 = datasnapshot.data()['service2'];
          service3 = datasnapshot.data()['service3'];
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
        title: Text("Plaza Senayan"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>ReserveList()),
          ),
        ),
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
                      "assets/ps.png",
                      width: 100,
                    ),
                    Text(
                      "  ",
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Plaza Senayan",
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
                      "Jalan Asia Afrika 8",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Tanah Abang",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Central Jakarta\n",
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
                          hintText: "Parking: " + dummyparking.toString(),
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
                          hintText: "Valet: " + dummyvalet.toString(),
                          hintStyle: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontFamily: 'Raleway'),
                          prefixIcon: Icon(Icons.drive_eta_rounded,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),

                    new TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.deepOrangeAccent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent, width: 5.0),
                        ),
                        hintText: "Facilities and Amenities:" +
                            "\n" +
                            "\n" +
                            service1 +
                            "\n" +
                            service2 +
                            "\n" +
                            service3,
                        hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'Raleway'),
                        //  prefixIcon: Icon(Icons.shopping_cart_rounded,
                        //     size: 40, color: Colors.white),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new RaisedButton.icon(
                      onPressed: () {
                        // _signIn();
                        //if(user != null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlazaSenayanRes()),
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
