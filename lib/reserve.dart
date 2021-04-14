import 'dart:math' show cos, sqrt, asin;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkway/citywalk.dart';
import 'package:parkway/ctower.dart';
import 'package:parkway/gambir.dart';
import 'package:parkway/grandindo.dart';
import 'package:parkway/history.dart';
import 'package:parkway/home.dart';
import 'package:parkway/kokas.dart';
import 'package:parkway/map.dart';
import 'package:parkway/membership.dart';
import 'package:parkway/pacific.dart';
import 'package:parkway/payment.dart';
import 'package:parkway/plazaindo.dart';
import 'package:parkway/plazasemanggi.dart';
import 'package:parkway/plazasenayan.dart';
import 'package:parkway/promotions.dart';
import 'package:parkway/ritz.dart';
import 'package:parkway/sarinah.dart';
import 'package:parkway/search.dart';
import 'package:parkway/sency.dart';
import 'package:parkway/sudirmanplaza.dart';
import 'package:parkway/vouchers.dart';

import 'constants.dart';

double earthRadius = 6371000;
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

void main() {
  runApp(ReserveList());
}

class ReserveList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParkWay',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

var cityTowerRating;
var citywalkRating;
var gambirRating;
var grandIndoRating;
var kokasRating;
var pacificRating;
var plazaIndoRating;
var plazaSemanggiRating;
var plazaSenayanRating;
var ritzRating;
var sarinahRating;
var sencyRating;
var sudirmanRating;
var i = 0;
var cityTowerCounter;
var citywalkCounter;
var gambirCounter;
var grandIndoRCounter;
var kokasCounter;
var pacificCounter;
var plazaIndoCounter;
var plazaSemanggiCounter;
var plazaSenayanCounter;
var ritzCounter;
var sarinahCounter;
var sencyCounter;
var sudirmanCounter;

String citytower = "City Tower Sudirman";
var cityTowerPrice;
String citywalk = "Citywalk Sudirman";
var citywalkPrice;
String gambir = "Gambir Station";
var gambirPrice;
String grandindonesia = "Grand Indonesia";
var grandindonesiaPrice;
String kotakasablanka = "Kota Kasablanka";
var kotakasablankaPrice;
String pacificplace = "Pacific Place";
var pacificplacePrice;
String plazaindonesia = "Plaza Indonesia";
var plazaindonesiaPrice;
String plazasemanggi = "Plaza Semanggi";
var plazasemanggiPrice;
String plazasenayan = "Plaza Senayan";
var plazasenayanPrice;
String ritzcarlton = "Ritz-Carlton";
var ritzcarltonPrice;
String sarinah = "Sarinah";
var sarinahPrice;
String senayancity = "Senayan City";
var senayancityPrice;
String sudirmanplaza = "Sudirman Plaza";
var sudirmanplazaPrice;

var points;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("Users" + "/" + name);

  final DocumentReference cityTowerReference =
      FirebaseFirestore.instance.doc("Places" + "/" + citytower);
  final DocumentReference citywalkReference =
      FirebaseFirestore.instance.doc("Places" + "/" + citywalk);
  final DocumentReference gambirReference =
      FirebaseFirestore.instance.doc("Places" + "/" + gambir);
  final DocumentReference grandindonesiaReference =
      FirebaseFirestore.instance.doc("Places" + "/" + grandindonesia);
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

  Future<void> getBalanceHere() async {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          points = datasnapshot.data()['points'];
        });
      }
      if (datasnapshot.exists == false) {
        Map<String, num> data = <String, num>{
          "balance": 0,
          "points": 0,
          "cardnumber": 0,
        };
        documentReference.setData(data);
        setState(() {
          balance = datasnapshot.data()['balance'];
          card = datasnapshot.data()['cardnumber'];
          points = datasnapshot.data()['points'];
        });
      }
    });

    cityTowerReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          cityTowerPrice = datasnapshot.data()['price'];
          cityTowerRating = datasnapshot.data()['rating'];
          cityTowerCounter = datasnapshot.data()['counter'];
          cityTowerRating = cityTowerRating / cityTowerCounter;
        });
      }
    });

    citywalkReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          citywalkPrice = datasnapshot.data()['price'];
          citywalkRating = datasnapshot.data()['rating'];
          citywalkCounter = datasnapshot.data()['counter'];
          citywalkRating = citywalkRating / citywalkCounter;
        });
      }
    });

    gambirReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          gambirPrice = datasnapshot.data()['price'];
          gambirRating = datasnapshot.data()['rating'];
          gambirCounter = datasnapshot.data()['counter'];
          gambirRating = gambirRating / gambirCounter;
        });
      }
    });

    grandindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          grandindonesiaPrice = datasnapshot.data()['price'];
          grandIndoRating = datasnapshot.data()['rating'];
          grandIndoRCounter = datasnapshot.data()['counter'];
          grandIndoRating = grandIndoRating / grandIndoRCounter;
        });
      }
    });

    kotakasablankaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          kotakasablankaPrice = datasnapshot.data()['price'];
          kokasRating = datasnapshot.data()['rating'];
          kokasCounter = datasnapshot.data()['counter'];
          kokasRating = kokasRating / kokasCounter;
        });
      }
    });

    pacificplaceReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          pacificplacePrice = datasnapshot.data()['price'];
          pacificRating = datasnapshot.data()['rating'];
          pacificCounter = datasnapshot.data()['counter'];
          pacificRating = pacificRating / pacificCounter;
        });
      }
    });

    plazaindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazaindonesiaPrice = datasnapshot.data()['price'];
          plazaIndoRating = datasnapshot.data()['rating'];
          plazaIndoCounter = datasnapshot.data()['counter'];
          plazaIndoRating = plazaIndoRating / plazaIndoCounter;
        });
      }
    });

    plazasemanggiReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasemanggiPrice = datasnapshot.data()['price'];
          plazaSemanggiRating = datasnapshot.data()['rating'];
          plazaSemanggiCounter = datasnapshot.data()['counter'];
          plazaSemanggiRating = plazaSemanggiRating / plazaSemanggiCounter;
        });
      }
    });

    plazasenayanReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasenayanPrice = datasnapshot.data()['price'];
          plazaSenayanRating = datasnapshot.data()['rating'];
          plazaSenayanCounter = datasnapshot.data()['counter'];
          plazaSenayanRating = plazaSenayanRating / plazaSenayanCounter;
        });
      }
    });

    ritzcarltonReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          ritzcarltonPrice = datasnapshot.data()['price'];
          ritzRating = datasnapshot.data()['rating'];
          ritzCounter = datasnapshot.data()['counter'];
          ritzRating = ritzRating / ritzCounter;
        });
      }
    });

    sarinahReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sarinahPrice = datasnapshot.data()['price'];
          sarinahRating = datasnapshot.data()['rating'];
          sarinahCounter = datasnapshot.data()['counter'];
          sarinahRating = sarinahRating / sarinahCounter;
        });
      }
    });

    senayancityReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          senayancityPrice = datasnapshot.data()['price'];
          sencyRating = datasnapshot.data()['rating'];
          sencyCounter = datasnapshot.data()['counter'];
          sencyRating = sencyRating / sencyCounter;
        });
      }
    });

    sudirmanplazaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sudirmanplazaPrice = datasnapshot.data()['price'];
          sudirmanRating = datasnapshot.data()['rating'];
          sudirmanCounter = datasnapshot.data()['counter'];
          sudirmanRating = sudirmanRating / sudirmanCounter;
        });
      }
    });
  }

  List<Widget> itemsData = [];
  List<Widget> listItems = [];

  void toast() {
    Fluttertoast.showToast(
      msg:
          "Use the app back button to navigate to the previous page\nDo not use the back button\nof your device or it will\ncrash the application!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      //backgroundColor: "#e74c3c",
      //Timer(Duration(seconds: 5), () => goToLogin(context));
    );
  }

  void getLocData() async {
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
    double citywalkDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.208590611715428, 106.81764705100849);
    String citywalk = citywalkDistance.toStringAsFixed(2);
    double grandIndoDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.196746580727995, 106.82256895028455);
    String grandIndo = grandIndoDistance.toStringAsFixed(2);
    double pacificDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.224101298778742, 106.80973889382585);
    String pacific = pacificDistance.toStringAsFixed(2);
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
    String gambir = gambirDistance.toStringAsFixed(2);
    double kokasDistance = calculateDistance(currPos.latitude,
        currPos.longitude, -6.223572575946641, 106.8433518321592);
    String kokas = kokasDistance.toStringAsFixed(2);

    List<String> dashList = LOC_DATA;

    final locMap = dashList.asMap();
    final nameOne = locMap[1];

    listItems.add(InkWell(
      child: Container(
          height: 170,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      citytower,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.grey),
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Icon(Icons.star_rounded),
                            ),
                          ),
                          TextSpan(text: cityTowerRating.toStringAsFixed(1)),
                        ],
                      ),
                    ),
                    Text(
                      cityTower + " kilometers away",
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rp. " + cityTowerPrice.toString(),
                      style: const TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Image.asset(
                  "assets/citytower.jpg",
                  height: 200,
                )
              ],
            ),
          )),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CTower()));
      },
    ));
    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Citywalk Sudirman",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: citywalkRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        citywalk + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + citywalkPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset("assets/citywalk.jpg", width: 100)
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Citywalk()),
          );
        },
      ),
    );

    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Gambir Station",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: gambirRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        gambir + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + gambirPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset("assets/gambir.jpg", width: 100)
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Gambir()),
          );
        },
      ),
    );

    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Grand Indonesia",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: grandIndoRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        grandIndo + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + grandindonesiaPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/gi.jpg",
                    height: 90,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GrandIndo()),
          );
        },
      ),
    );

    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Kota Kasablanka",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: kokasRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        kokas + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + kotakasablankaPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/kokas.png",
                    height: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Kokas()),
          );
        },
      ),
    );

    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Pacific Place",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: pacificRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        pacific + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + pacificplacePrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/pp.jpg",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pacific()),
          );
        },
      ),
    );

    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Plaza Indonesia",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: plazaIndoRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        plazaIndo + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + plazaindonesiaPrice.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/pi.png",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlazaIndo()),
          );
        },
      ),
    );
    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Plaza Semanggi",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(
                                text: plazaSemanggiRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        plazaSemanggi + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + plazasemanggiPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/smg.jpg",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlazaSemanggi()),
          );
        },
      ),
    );
    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Plaza Senayan",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(
                                text: plazaSenayanRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        plazaSenayan + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + plazasenayanPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/ps.png",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlazaSenayan()),
          );
        },
      ),
    );
    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Ritz-Carlton",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: ritzRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        ritzCarlton + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + ritzcarltonPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/ritz.jpg",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Ritz()),
          );
        },
      ),
    );
    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sarinah",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: sarinahRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        sarinah + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + sarinahPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/sarinah.png",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sarinah()),
          );
        },
      ),
    );
    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Senayan City",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: sencyRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        senayanCity + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + senayancityPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/sency.jpg",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sency()),
          );
        },
      ),
    );

    listItems.add(
      InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sudirman Plaza",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey),
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Icon(Icons.star_rounded),
                              ),
                            ),
                            TextSpan(text: sudirmanRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Text(
                        sudirmanPlaza + " kilometers away",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp. " + sudirmanplazaPrice.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/suplaz.jpg",
                    width: 100,
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SudirmanPlaza()),
          );
        },
      ),
    );

    for (i = 0; i <= 30; i++) {
      listItems.add(InkWell(
        child: Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "More places to be added soon!",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SudirmanPlaza()),
          );
        },
      ));
    }

    setState(() {
      itemsData = listItems;
    });
  }

  void loading() {
    for (i = 0; i <= 1; i++) {}
  }

  @override
  void initState() {
    super.initState();
    //loading();
    //getLocData();
    getBalanceHere();
    toast();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  Future refreshData() async {
    setState(() {
      getLocData();
      //itemsData = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    getLocData();

    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return RefreshIndicator(
      onRefresh: refreshData,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Dashboard'),
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
                ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.watch_later_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_balance_wallet_rounded,
                  color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Payment()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              },
            ),
          ],
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //Text(
                  //"Loyality Cards",
                  // style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                  // ),
                  //  Text(
                  //   "Menu",
                  //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  //  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
                    child: categoriesScroller),
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Membership",
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "View points",
                          //points.toStringAsFixed(0) + " points",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Membership()));
                },
              ),
              InkWell(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Vouchers",
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                          Text(
                            "View vouchers",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Vouchers()));
                },
              ),
              InkWell(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(
                        "Promotions",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: 10,
                        ),
                        Text(
                          "View deals",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Promotions()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
