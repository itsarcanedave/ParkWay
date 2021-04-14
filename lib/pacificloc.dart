import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/home.dart';
import 'package:parkway/p1.dart';
import 'package:parkway/p2.dart';
import 'package:parkway/p3.dart';
import 'package:parkway/p4.dart';
import 'package:parkway/p5.dart';
import 'package:parkway/p6.dart';

class PacificLoc extends StatefulWidget {
  @override
  PacificLocState createState() {
    return new PacificLocState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;
String place = "Pacific Place";
String valetstatus;
String grandIndoD;
String citywalkD;
String kokasD;
String pacificD;
String cityTowerText;
String citywalkText;
String gambirText;
String grandIndoText;
String kokasText;
String pacificText;
String plazaIndoText;
String plazaSemanggiText;
String plazaSenayanText;
String ritzText;
String sarinahText;
String sencyText;
String sudirmanPlazaText;
String citytower = "City Tower Sudirman";
String cityTowerPrice;
String citywalk = "Citywalk Sudirman";
String citywalkPrice;
String gambir = "Gambir Station";
String gambirPrice;
String grandindonesia = "Grand Indonesia";
String grandindonesiaPrice;
String kotakasablanka = "Kota Kasablanka";
String kotakasablankaPrice;
String pacificplace = "Pacific Place";
String pacificplacePrice;
String plazaindonesia = "Plaza Indonesia";
String plazaindonesiaPrice;
String plazasemanggi = "Plaza Semanggi";
String plazasemanggiPrice;
String plazasenayan = "Plaza Senayan";
String plazasenayanPrice;
String ritzcarlton = "Ritz-Carlton";
String ritzcarltonPrice;
String sarinah = "Sarinah";
String sarinahPrice;
String senayancity = "Senayan City";
String senayancityPrice;
String sudirmanplaza = "Sudirman Plaza";
String sudirmanplazaPrice;
var time = DateTime.now().millisecondsSinceEpoch.toString();

class PacificLocState extends State<PacificLoc> {
  var price;
  var valet;
  var hours;
  var total;
  var balance;
  var card;
  var topup;
  var amount;
  var code;

  bool isSwitched = false;
  StreamSubscription<DocumentSnapshot> subscription;
  CollectionReference users = FirebaseFirestore.instance.collection(name);

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("Users" + "/" + name);

  final DocumentReference placeReference =
      FirebaseFirestore.instance.doc("Places" + "/" + place);

  final DocumentReference bookingReference = FirebaseFirestore.instance
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + time);
  final DocumentReference cityTowerReference =
      FirebaseFirestore.instance.doc("Places" + "/" + citytower);
  final DocumentReference citywalkReference =
      FirebaseFirestore.instance.doc("Places" + "/" + citywalk);
  final DocumentReference gambirReference =
      FirebaseFirestore.instance.doc("Places" + "/" + gambir);
  final DocumentReference grandindonesiaReference =
      FirebaseFirestore.instance.doc("Places" + "/" + "Grand Indonesia");
  final DocumentReference kotakasablankaReference =
      FirebaseFirestore.instance.doc("Places" + "/" + kotakasablanka);
  final DocumentReference pacificplaceReference =
      FirebaseFirestore.instance.doc("Places" + "/" + pacificplace);
  final DocumentReference plazaindonesiaReference =
      FirebaseFirestore.instance.doc("Places" + "/" + plazaindonesia);
  final DocumentReference plazasemanggiReference =
      FirebaseFirestore.instance.doc("Places" + "/" + plazasemanggi);
  final DocumentReference plazasenayanReference =
      FirebaseFirestore.instance.doc("Places" + "/" + plazasenayan);
  final DocumentReference ritzcarltonReference =
      FirebaseFirestore.instance.doc("Places" + "/" + ritzcarlton);
  final DocumentReference sarinahReference =
      FirebaseFirestore.instance.doc("Places" + "/" + sarinah);
  final DocumentReference senayancityReference =
      FirebaseFirestore.instance.doc("Places" + "/" + senayancity);
  final DocumentReference sudirmanplazaReference =
      FirebaseFirestore.instance.doc("Places" + "/" + sudirmanplaza);

  bool finish = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
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

    double citywalkDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.208590611715428, 106.81764705100849);
    citywalkD = citywalkDistance.toStringAsFixed(2);
    double grandIndoDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.196746580727995, 106.82256895028455);
    grandIndoD = grandIndoDistance.toStringAsFixed(2);
    double pacificDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.224101298778742, 106.80973889382585);
    pacificD = pacificDistance.toStringAsFixed(2);
    double plazaIndoDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.208590611715428, 106.81764705100849);
    String plazaIndo = plazaIndoDistance.toStringAsFixed(2);
    double plazaSemanggiDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.219701635798008, 106.81446568826847);
    String plazaSemanggi = plazaSemanggiDistance.toStringAsFixed(2);
    double plazaSenayanDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.225330942133653, 106.7996869300261);
    String plazaSenayan = plazaSenayanDistance.toStringAsFixed(2);
    double ritzCarltonDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.228744816929019, 106.82702840610564);
    String ritzCarlton = ritzCarltonDistance.toStringAsFixed(2);
    double sarinahDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.187251205670757, 106.82417237927989);
    String sarinah = sarinahDistance.toStringAsFixed(2);
    double senayanCityDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.227203389715999, 106.79739829495486);
    String senayanCity = senayanCityDistance.toStringAsFixed(2);
    double sudirmanPlazaDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.208684335998033, 106.82246688684239);
    String sudirmanPlaza = sudirmanPlazaDistance.toStringAsFixed(2);
    double gambirDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.176673044686259, 106.83052811106369);
    //gambirD = gambirDistance.toStringAsFixed(2);
    double kokasDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.223572575946641, 106.8433518321592);
    kokasD = kokasDistance.toStringAsFixed(2);
  }

  void _process() {
    // Map<String, String> data = <String, String>{
    // "balance": ""
    //};

    Map<String, String> data = <String, String>{
      "place": place,
      "hours": hours.toString(),
      "price": total.toString(),
      "valet": valetstatus,
    };

    bookingReference.setData(data);

    documentReference.update({"balance": FieldValue.increment(total * -1)});

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['balance'];
        });
      }
    });
  }

  void _getBalance() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['balance'];
          //ard = datasnapshot.data()['cardnumber'];
        });
      }
    });
    placeReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          price = datasnapshot.data()['price'];
          valet = datasnapshot.data()['valet'];
          //ard = datasnapshot.data()['cardnumber'];
        });
      }
    });
    citywalkReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          citywalkPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    gambirReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          gambirPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    grandindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          grandindonesiaPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    kotakasablankaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          kotakasablankaPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    pacificplaceReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          pacificplacePrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    plazaindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazaindonesiaPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    plazasemanggiReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasemanggiPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    plazasenayanReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasenayanPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    ritzcarltonReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          ritzcarltonPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    sarinahReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sarinahPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    senayancityReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          senayancityPrice = datasnapshot.data()['longpromotion'];
        });
      }
    });

    sudirmanplazaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sudirmanplazaPrice = datasnapshot.data()['longpromotion'];
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
      total = (int.parse(hours) * price) + valet;
      valetstatus = "Yes";
    } else if (isSwitched == false) {
      total = (int.parse(hours) * price);
      valetstatus = "No";
    }
  }

  void performTopup() {
    _process();
    final snackbar = new SnackBar(
      content: new Text("Successfully added $amount to your balance"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    final form = formKey.currentState;
    form.reset();
  }

  @override
  void initState() {
    // : implement initState
    super.initState();
    _getBalance();
    getPostsData();
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
    // : implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _getBalance();
    if (total == null) {
      total = 0;
    }
    if (cityTowerPrice == "0") {
      cityTowerText = "You have no deals at this location";
    } else {
      cityTowerText = cityTowerPrice;
    }

    if (citywalkPrice == "0") {
      citywalkText = "You have no deals at this location";
    } else {
      citywalkText = citywalkPrice;
    }

    if (gambirPrice == "0") {
      gambirText = "You have no deals at this location";
    } else {
      gambirText = gambirPrice;
    }

    if (grandindonesiaPrice == "0") {
      grandIndoText = "You have no deals at this location";
    } else {
      grandIndoText = grandindonesiaPrice;
    }

    if (kotakasablankaPrice == "0") {
      kokasText = "You have no deals at this location";
    } else {
      kokasText = kotakasablankaPrice;
    }

    if (pacificplacePrice == "0") {
      pacificText = "You have no deals at this location";
    } else {
      pacificText = pacificplacePrice;
    }

    if (plazaindonesiaPrice == "0") {
      plazaIndoText = "You have no deals at this location";
    } else {
      plazaIndoText = plazaindonesiaPrice;
    }

    if (plazasemanggiPrice == "0") {
      plazaSemanggiText = "You have no deals at this location";
    } else {
      plazaSemanggiText = plazasemanggiPrice;
    }

    if (plazasenayanPrice == "0") {
      plazaSenayanText = "You have no deals at this location";
    } else {
      plazaSenayanText = plazasenayanPrice;
    }

    if (ritzcarltonPrice == "0") {
      ritzText = "You have no deals at this location";
    } else {
      ritzText = ritzcarltonPrice;
    }

    if (sarinahPrice == "0") {
      sarinahText = "You have no deals at this location";
    } else {
      sarinahText = sarinahPrice;
    }

    if (senayancityPrice == "0") {
      sencyText = "You have no deals at this location";
    } else {
      sencyText = senayancityPrice;
    }

    if (sudirmanplazaPrice == "0") {
      sudirmanPlazaText = "You have no deals at this location";
    } else {
      sudirmanPlazaText = sudirmanplazaPrice;
    }
    double cityTowerTime;
    cityTowerTime = (double.parse(pacificD)) / 40 * 60;
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Choose Parking Space"),
        leading: IconButton(
          icon: Icon(Icons.home_outlined, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ),
        ),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Text(
              "Pacific Place\n",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Colors.blueAccent,
              //onPressed: _add,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => P4()));
                //   Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => TopUp()),
                //  );
              },
              child: new Text(
                "Lower Ground",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Colors.blueAccent,
              //onPressed: _add,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => P5()));
                //   Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => TopUp()),
                //  );
              },
              child: new Text(
                "Ground Floor",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Colors.blueAccent,
              //onPressed: _add,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => P6()));
                //   Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => TopUp()),
                //  );
              },
              child: new Text(
                "Upper Ground",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            new Container(
                child: Row(
              children: <Widget>[
                Flexible(
                  child: new TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 100,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 5.0),
                      ),
                      hintText: " " + pacificD + " kilometers away",
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Raleway'),
                      prefixIcon: Icon(Icons.near_me_rounded,
                          size: 40, color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Container(
                child: Row(
              children: <Widget>[
                Flexible(
                  child: new TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 100,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 5.0),
                      ),
                      hintText: " " +
                          cityTowerTime.toStringAsFixed(0) +
                          " minutes to location",
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Raleway'),
                      prefixIcon: Icon(Icons.watch_later_rounded,
                          size: 40, color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Container(
                child: Row(
              children: <Widget>[
                Flexible(
                  child: new TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 100,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 5.0),
                      ),
                      hintText: "" + pacificText,
                      hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Raleway'),
                      prefixIcon: Icon(Icons.card_giftcard_rounded,
                          size: 40, color: Colors.white),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
