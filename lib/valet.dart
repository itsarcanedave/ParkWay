import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/timerwall.dart';

class Valet extends StatefulWidget {
  @override
  ValetState createState() {
    return new ValetState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;
String place;
String uplace;
String valetstatus;
var uratepark = 12000;
var urateval = 50000;
double time;
String distance;

class ValetState extends State<Valet> {
  var valet;
  var hours;
  var total;
  var balance;
  var card;
  var topup;
  var amount;
  var code;
  var dummyparking;
  var dummyvalet;
  String uvalet;
  var uhours;
  var uprice;
  var uratepark;
  String custName;
  String custNumber;
  String custPlate;

  bool isSwitched = false;
  StreamSubscription<DocumentSnapshot> subscription;
  CollectionReference users = FirebaseFirestore.instance.collection(name);

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("Users" + "/" + name);

  final DocumentReference bookingReference = FirebaseFirestore.instance
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + "latest");

  final DocumentReference historyReference = FirebaseFirestore.instance
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + "latest");

  bool finish = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  /*void getPostsData() async {
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

    if (uplace == "City Tower Sudirman"){
      double cityTowerDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.19910844638473, 106.82351935077837);
      distance = cityTowerDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Citywalk Sudirman") {
      double citywalkDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.208590611715428, 106.81764705100849);
      distance = citywalkDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Gambir Station") {
      double gambirDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.176673044686259, 106.83052811106369);
      distance = gambirDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Grand Indonesia") {
      double grandIndoDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.196746580727995, 106.82256895028455);
      distance = grandIndoDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Kota Kasablanka") {
      double kokasDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.223572575946641, 106.8433518321592);
      distance = kokasDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Pacific Place") {
      double pacificDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.224101298778742, 106.80973889382585);
      distance = pacificDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Plaza Indonesia") {
      double plazaIndoDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.208590611715428, 106.81764705100849);
      distance = plazaIndoDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Plaza Semanggi") {
      double plazaSemanggiDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.219701635798008, 106.81446568826847);
      distance = plazaSemanggiDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Plaza Senayan") {
      double plazaSenayanDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.225330942133653, 106.7996869300261);
      distance = plazaSenayanDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Ritz-Carlton") {
      double ritzCarltonDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.228744816929019, 106.82702840610564);
      distance = ritzCarltonDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Sarinah") {
      double sarinahDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.187251205670757, 106.82417237927989);
      distance = sarinahDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Senayan City") {
      double senayanCityDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.227203389715999, 106.79739829495486);
      distance = senayanCityDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    } else if (uplace == "Sudirman Plaza") {
      double sudirmanPlazaDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.208684335998033, 106.82246688684239);
      distance = sudirmanPlazaDistance.toStringAsFixed(2);
      setState(() {
        time = (double.parse(distance)) / 40 * 60;
      });
    }



  }


*/

  void _process() {
    // Map<String, String> data = <String, String>{
    // "balance": ""
    //};
    //getPostsData();
    final DocumentReference valetReference =
        FirebaseFirestore.instance.doc("Valet" + "/" + uplace);

    //valetReference.update({"$name": custName + " " +  custNumber + " " + custPlate + " " + uhours.toString() + " " + time.toStringAsFixed(0)});
    valetReference.update({
      "$name": custName +
          " " +
          custNumber +
          " " +
          custPlate +
          " " +
          uhours.toString()
    });

    // documentReference
    //   .update({"points": FieldValue.increment(total/1000)});
  }

  void _getBalance() {
    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          uhours = int.parse(datasnapshot.data()['hours']);
          uplace = datasnapshot.data()['place'];
          //uprice = int.parse(datasnapshot.data()['price']);
          uvalet = datasnapshot.data()['valet'];
          //getPostsData();
          if (uvalet == "Yes") {
            uvalet = "requested";
            //isSwitched = true;

          } else {
            uvalet = "not requested";
            //isSwitched = false;

          }
        });
      }
      if (datasnapshot.exists == false) {
        uplace = "You have no ongoing reservations";
        uhours = " ";
        uprice = " ";
        uvalet = " ";
      }
    });

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['balance'];
          //ard = datasnapshot.data()['cardnumber'];
        });
      }
    });
  }

  void _topup() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      performTopup();
    }
  }

  void _calculate() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      performCalc();
    }
  }

  void performCalc() {
    if (isSwitched == true) {
      total = int.parse(hours) * uratepark + urateval;
      valetstatus = "Yes";
    } else if (isSwitched == false) {
      total = int.parse(hours) * uratepark;
      valetstatus = "No";
    }
  }

  void performTopup() {
    _process();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimerWall()),
    );
    _getBalance();
    final form = formKey.currentState;
    form.reset();
  }

  @override
  void initState() {
    _getBalance();
    //getPostsData();
    place = uplace;
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          //     myText = datasnapshot.data()['desc'];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _getBalance();
    uratepark = 20000;

    if (uplace == null) {
      uplace = " ";
    }
    if (uhours == null) {
      hours = " ";
    }
    if (uprice == null) {
      uprice = " ";
    }
    if (uvalet == null) {
      valet = " ";
    }
    if (total == null) {
      total = 0;
    }
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text("Valet Reservation"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.all(20.0)),
                    new Text(
                      uplace + "\n",
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "You reserved for " + uhours.toString() + " hours \n",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(labelText: "Full Name"),
                      style: new TextStyle(fontSize: 18),
                      validator: (val) => val.contains(new RegExp(r'[0-9]'))
                          ? 'Invalid Amount!'
                          : null,
                      onSaved: (val) => setState(() {
                        custName = val;
                      }),
                    ),
                    new TextFormField(
                      decoration:
                          new InputDecoration(labelText: "Phone Number"),
                      style: new TextStyle(fontSize: 18),
                      validator: (val) => val.contains(new RegExp(r'[A-Z]'))
                          ? 'Invalid Amount!'
                          : null,
                      onSaved: (val) => setState(() {
                        custNumber = val;
                      }),
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Vehicle Identification Number"),
                      style: new TextStyle(fontSize: 18),
                      //validator: (val) => val.contains(new RegExp(r'[A-Z]'))
                      //  ? 'Invalid Amount!'
                      // : null,
                      onSaved: (val) => setState(() {
                        custPlate = val;
                      }),
                    ),
                    new Padding(padding: const EdgeInsets.all(20.0)),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new RaisedButton.icon(
                      onPressed: _topup,

                      //Timer(Duration(seconds: 5), () =>
                      //);
                      //},
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      label: Text(
                        'CONFIRM RESERVATION',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.local_parking_rounded,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.blue,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            )));
  }
}
