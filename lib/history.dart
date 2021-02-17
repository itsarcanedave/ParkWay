import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/modify.dart';
import 'package:parkway/cancel.dart';
import 'package:parkway/home.dart';
import 'package:parkway/nohistory.dart';

class History extends StatefulWidget {
  @override
  HistoryState createState() {
    return new HistoryState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

class HistoryState extends State<History> {
  String myText;
  var balance;
  var card;
  var points;
  String hours;
  String place;
  String price;
  String valet;
  bool isEnabled;
  String hrs;
  String vlt;
  String prc;

  StreamSubscription<DocumentSnapshot> subscription;
  CollectionReference users = FirebaseFirestore.instance.collection(name);

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("Users" + "/" + name);

  final DocumentReference historyReference = FirebaseFirestore.instance
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + "latest");

  bool finish = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

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
        setState(() {
          hours = datasnapshot.data()['hours'];
          place = datasnapshot.data()['place'];
          price = datasnapshot.data()['price'];
          valet = datasnapshot.data()['valet'];
        });
      }
      if (datasnapshot.exists == false) {}
    });
  }

  @override
  void initState() {
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
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _boolcheckmap() {
      if (place == "No reservations") {
        return null;
      }
    }

    _boolcheckmodify() {
      if (place == "No reservations") {
        return null;
      } else {
        return (() => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Modify()),
            ));
      }
    }

    _boolcheckcancel() {
      if (place == "No reservations") {
        return null;
      } else {
        return (() => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cancel()),
            ));
      }
    }

    if (place == null) {
      place = "No reservations";
    }
    if (hours == null) {
      hrs = "Make one from the Dashboard!";
    } else {
      hrs = "Reserved for " + hours + " hours";
    }
    if (price == null) {
      prc = " ";
    } else {
      prc = "Rp. " + price;
    }
    if (valet == null) {
      vlt = " ";
    } else {
      vlt = "Valet parking " + valet;
    }

    String tempCard;
    if (valet == "Yes") {
      valet = "requested";
    } else if (valet == "No") {
      valet = "not requested";
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Ongoing Reservations"),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            ),
          ),
        ),
        body: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            child: Container(
                height: 300,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(100), blurRadius: 10.0),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            place,
                            style: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            hrs,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.grey),
                          ),
                          Text(
                            vlt,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            prc,
                            style: const TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          new Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new RaisedButton.icon(
                                onPressed: _boolcheckmap(),

                                // _signIn();
                                //if(user != null){
                                //  Navigator.push(
                                //      context,
                                //     MaterialPageRoute(
                                //         builder: (context) => CTowerRes()),
                                //    );

                                //Timer(Duration(seconds: 5), () =>
                                //);
                                //},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                label: Text(
                                  'VIEW MAP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                icon: Icon(
                                  Icons.local_parking_rounded,
                                  color: Colors.white,
                                ),
                                textColor: Colors.black,
                                splashColor: Colors.blue,
                                color: Colors.blue,
                              ),
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                              ),
                              new RaisedButton.icon(
                                onPressed: _boolcheckmodify(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                label: Text(
                                  'MODIFY',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                icon: Icon(
                                  Icons.mode_rounded,
                                  color: Colors.white,
                                ),
                                textColor: Colors.black,
                                splashColor: Colors.blue,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          new Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.all(5.0),
                              ),
                              new RaisedButton.icon(
                                onPressed: _boolcheckcancel(),

                                //Timer(Duration(seconds: 5), () =>
                                //);
                                //},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                label: Text(
                                  '   CANCEL RESERVATION   ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.white,
                                ),
                                textColor: Colors.black,
                                splashColor: Colors.blue,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Image.asset(
                      // "assets/suplaz.jpg",
                      // width: 100,
                      // )
                    ],
                  ),
                )),
            onTap: () {
              //Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => SudirmanPlaza()),
              //  );
            },
          ),
        ));
  }
}
