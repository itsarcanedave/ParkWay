import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/modify.dart';
import 'package:parkway/cancel.dart';
import 'package:parkway/home.dart';
import 'package:parkway/nohistory.dart';

class NoHistory extends StatefulWidget {
  @override
  NoHistoryState createState() {
    return new NoHistoryState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

class NoHistoryState extends State<NoHistory> {
  String myText;
  var balance;
  var card;
  var points;
  String hours;
  String place;
  String price;
  String valet;

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
      if (datasnapshot.exists == false) {
        place = "You have no ongoing reservations";
        hours = " ";
        price = " ";
        valet = " ";
      }
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
    if (place == null) {
      place = " ";
    }
    if (hours == null) {
      hours = " ";
    }
    if (price == null) {
      price = " ";
    }
    if (valet == null) {
      valet = " ";
    }

    String tempCard;
    if (valet == "Yes") {
      valet = "requested";
    } else {
      valet = "not requested";
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Ongoing Reservations"),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
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
                          "No on going reservations",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))));
  }
}
