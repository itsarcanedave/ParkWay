import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/home.dart';
import 'package:parkway/timer.dart';
import 'package:parkway/timerwall.dart';

class P3 extends StatefulWidget {
  @override
  P3State createState() {
    return new P3State();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;
String place = "City Tower Sudirman";
var rand;
double cityTowerTime;
String cityTowerD;
String valetstatus;
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

class P3State extends State<P3> {
  var price;
  var valet;
  var hours;
  var total;
  var balance;
  var card;
  var topup;
  var amount;
  var code;
  String p1;
  String p2;
  String p3;
  String p4;
  String p5;
  String p6;

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

  bool finish = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
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
    cityTowerD = cityTowerDistance.toStringAsFixed(2);
    setState(() {
      cityTowerTime = (double.parse(cityTowerD)) / 40 * 60;
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
    cityTowerReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          cityTowerPrice = datasnapshot.data()['longpromotion'];
          p1 = datasnapshot.data()['p1'];
          p2 = datasnapshot.data()['p2'];
          p3 = datasnapshot.data()['p3'];
          p4 = datasnapshot.data()['p3'];
          p5 = datasnapshot.data()['p3'];
          p6 = datasnapshot.data()['p3'];
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

  void getPosData() async {
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

    if (uplace == "City Tower Sudirman") {
      double cityTowerDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.19910844638473, 106.82351935077837);
      if (cityTowerDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Citywalk Sudirman") {
      double citywalkDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.208590611715428, 106.81764705100849);
      if (citywalkDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Gambir Station") {
      double gambirDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.176673044686259, 106.83052811106369);
      if (gambirDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Grand Indonesia") {
      double grandIndoDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.196746580727995, 106.82256895028455);
      if (grandIndoDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Kota Kasablanka") {
      double kokasDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.223572575946641, 106.8433518321592);
      if (kokasDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Pacific Place") {
      double pacificDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.224101298778742, 106.80973889382585);
      if (pacificDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Plaza Indonesia") {
      double plazaIndoDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.208590611715428, 106.81764705100849);
      if (plazaIndoDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Plaza Semanggi") {
      double plazaSemanggiDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.219701635798008, 106.81446568826847);
      if (plazaSemanggiDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Plaza Senayan") {
      double plazaSenayanDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.225330942133653, 106.7996869300261);
      if (plazaSenayanDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Ritz-Carlton") {
      double ritzCarltonDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.228744816929019, 106.82702840610564);
      if (ritzCarltonDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Sarinah") {
      double sarinahDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.187251205670757, 106.82417237927989);
      if (sarinahDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Senayan City") {
      double senayanCityDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.227203389715999, 106.79739829495486);
      if (senayanCityDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
    if (uplace == "Sudirman Plaza") {
      double sudirmanPlazaDistance = calculateDistance(currPos.latitude,
          currPos.longitude, -6.208684335998033, 106.82246688684239);
      if (sudirmanPlazaDistance == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Timer()));
      }
    }
  }

  int random(min, max) {
    var rn = new Random();
    return rand = min + rn.nextInt(max - min);
  }

  @override
  void initState() {
    getPosData();
    getPostsData();
    random(1, 7);
    // : implement initState
    super.initState();
    _getBalance();

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
    print(p1);
    getPosData();
    random(min, max) {
      var rn = new Random();
      return min + rn.nextInt(max - min);
    }

    print(random(5, 20));
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Location Map"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Text(
            "Your parking location is B" + rand.toString(),
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          new Padding(
            padding: const EdgeInsets.all(10.0),
          ),
          Center(
            /*  child: PinchZoom(
          image: Image.network(p1),
          zoomedBackgroundColor: Colors.black.withOpacity(0.5),
          resetDuration: const Duration(milliseconds: 100),
          maxScale: 2.5,
          onZoomStart: (){print('Start zooming');},
          onZoomEnd: (){print('Stop zooming');},
       */// ),
            child: InteractiveViewer(
              child: Image.network(p3),
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
                  MaterialPageRoute(builder: (context) => TimerWall()));
            },
            child: new Text(
              "I HAVE ARRIVED",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

}
