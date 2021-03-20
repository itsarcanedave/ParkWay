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
import 'package:parkway/membership.dart';
import 'package:parkway/pacific.dart';
import 'package:parkway/payment.dart';
import 'package:parkway/plazaindo.dart';
import 'package:parkway/plazasemanggi.dart';
import 'package:parkway/plazasenayan.dart';
import 'package:parkway/promotions.dart';
import 'package:parkway/reserve.dart';
import 'package:parkway/ritz.dart';
import 'package:parkway/sarinah.dart';
import 'package:parkway/search.dart';
import 'package:parkway/sency.dart';
import 'package:parkway/sudirmanplaza.dart';

import 'constants.dart';

double earthRadius = 6371000;
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

void main() {
  runApp(Vouchers());
}

class Vouchers extends StatelessWidget {
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
final scaffoldKey = new GlobalKey<ScaffoldState>();
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

  void _getBalance() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['balance'];
          card = datasnapshot.data()['cardnumber'];
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
        });
      }
    });

    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {});
      }
      if (datasnapshot.exists == false) {}
    });

    cityTowerReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          cityTowerPrice = datasnapshot.data()['discount'];
        });
      }
    });

    citywalkReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          citywalkPrice = datasnapshot.data()['discount'];
        });
      }
    });

    gambirReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          gambirPrice = datasnapshot.data()['discount'];
        });
      }
    });

    grandindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          grandindonesiaPrice = datasnapshot.data()['discount'];
        });
      }
    });

    kotakasablankaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          kotakasablankaPrice = datasnapshot.data()['discount'];
        });
      }
    });

    pacificplaceReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          pacificplacePrice = datasnapshot.data()['discount'];
        });
      }
    });

    plazaindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazaindonesiaPrice = datasnapshot.data()['discount'];
        });
      }
    });

    plazasemanggiReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasemanggiPrice = datasnapshot.data()['discount'];
        });
      }
    });

    plazasenayanReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasenayanPrice = datasnapshot.data()['discount'];
        });
      }
    });

    ritzcarltonReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          ritzcarltonPrice = datasnapshot.data()['discount'];
        });
      }
    });

    sarinahReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sarinahPrice = datasnapshot.data()['discount'];
        });
      }
    });

    senayancityReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          senayancityPrice = datasnapshot.data()['discount'];
        });
      }
    });

    sudirmanplazaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sudirmanplazaPrice = datasnapshot.data()['discount'];
        });
      }
    });
  }

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
        });
      }
    });

    citywalkReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          citywalkPrice = datasnapshot.data()['price'];
        });
      }
    });

    gambirReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          gambirPrice = datasnapshot.data()['price'];
        });
      }
    });

    grandindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          grandindonesiaPrice = datasnapshot.data()['price'];
        });
      }
    });

    kotakasablankaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          kotakasablankaPrice = datasnapshot.data()['price'];
        });
      }
    });

    pacificplaceReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          pacificplacePrice = datasnapshot.data()['price'];
        });
      }
    });

    plazaindonesiaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazaindonesiaPrice = datasnapshot.data()['price'];
        });
      }
    });

    plazasemanggiReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasemanggiPrice = datasnapshot.data()['price'];
        });
      }
    });

    plazasenayanReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          plazasenayanPrice = datasnapshot.data()['price'];
        });
      }
    });

    ritzcarltonReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          ritzcarltonPrice = datasnapshot.data()['price'];
        });
      }
    });

    sarinahReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sarinahPrice = datasnapshot.data()['price'];
        });
      }
    });

    senayancityReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          senayancityPrice = datasnapshot.data()['price'];
        });
      }
    });

    sudirmanplazaReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          sudirmanplazaPrice = datasnapshot.data()['price'];
        });
      }
    });
  }

  List<Widget> itemsData = [];
  List<Widget> listItems = [];

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

    String sudirmanPrice = "Rp. 12.000";
    String thamrinPrice = "Rp. 10.000";
    String kuninganPrice = "Rp. 8.000";
    String otherPrice = "Rp. 5.000";
    List<String> dashList = LOC_DATA;

    final locMap = dashList.asMap();
    final nameOne = locMap[1];

    listItems.add(InkWell(
      child: Container(
          height: 100,
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      cityTowerText,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    )
                  ],
                ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(citywalkText,
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey))
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        gambirText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        grandIndoText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        kokasText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        pacificText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        plazaIndoText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        plazaSemanggiText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        plazaSenayanText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ritzText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sarinahText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sencyText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
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
            height: 100,
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sudirmanPlazaText,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.grey),
                      )
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
      ),
    );

    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    _getBalance();
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
      itemsData = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cityTowerPrice == 0) {
      cityTowerText = "You have no discounts at this location";
    } else {
      cityTowerText =
          "Get Rp. " + cityTowerPrice.toString() + " off at this location";
    }

    if (citywalkPrice == 0) {
      citywalkText = "You have no discounts at this location";
    } else {
      citywalkText =
          "Get Rp. " + citywalkPrice.toString() + " off at this location";
    }

    if (gambirPrice == 0) {
      gambirText = "You have no discounts at this location";
    } else {
      gambirText =
          "Get Rp. " + gambirPrice.toString() + " off at this location";
    }

    if (grandindonesiaPrice == 0) {
      grandIndoText = "You have no discounts at this location";
    } else {
      grandIndoText =
          "Get Rp. " + grandindonesiaPrice.toString() + " off at this location";
    }

    if (kotakasablankaPrice == 0) {
      kokasText = "You have no discounts at this location";
    } else {
      kokasText =
          "Get Rp. " + kotakasablankaPrice.toString() + " off at this location";
    }

    if (pacificplacePrice == 0) {
      pacificText = "You have no discounts at this location";
    } else {
      pacificText =
          "Get Rp. " + pacificplacePrice.toString() + " off at this location";
    }

    if (plazaindonesiaPrice == 0) {
      plazaIndoText = "You have no discounts at this location";
    } else {
      plazaIndoText =
          "Get Rp. " + plazaindonesiaPrice.toString() + " off at this location";
    }

    if (plazasemanggiPrice == 0) {
      plazaSemanggiText = "You have no discounts at this location";
    } else {
      plazaSemanggiText =
          "Get Rp. " + plazasemanggiPrice.toString() + " off at this location";
    }

    if (plazasenayanPrice == 0) {
      plazaSenayanText = "You have no discounts at this location";
    } else {
      plazaSenayanText =
          "Get Rp. " + plazasenayanPrice.toString() + " off at this location";
    }

    if (ritzcarltonPrice == 0) {
      ritzText = "You have no discounts at this location";
    } else {
      ritzText =
          "Get Rp. " + ritzcarltonPrice.toString() + " off at this location";
    }

    if (sarinahPrice == 0) {
      sarinahText = "You have no discounts at this location";
    } else {
      sarinahText =
          "Get Rp. " + sarinahPrice.toString() + " off at this location";
    }

    if (senayancityPrice == 0) {
      sencyText = "You have no discounts at this location";
    } else {
      sencyText =
          "Get Rp. " + senayancityPrice.toString() + " off at this location";
    }

    if (sudirmanplazaPrice == 0) {
      sudirmanPlazaText = "You have no discounts at this location";
    } else {
      sudirmanPlazaText =
          "Get Rp. " + sudirmanplazaPrice.toString() + " off at this location";
    }

    if (points == null) {
      points = 0;
    }
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return RefreshIndicator(
      onRefresh: refreshData,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Vouchers'),
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReserveList()),
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
                            "You are here!",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "You are already here!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity:
                        ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
                    //backgroundColor: "#e74c3c",
                    //textColor: '#ffffff'
                  );
                },
              ),
              InkWell(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Make a booking",
                          //points.toStringAsFixed(0) + " points",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReserveList()));
                },
              ),
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
