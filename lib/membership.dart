import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/reserve.dart';

class Membership extends StatefulWidget {
  @override
  MembershipState createState() {
    return new MembershipState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

class MembershipState extends State<Membership> {
  String myText;
  var balance;
  var card;
  var topup;
  var amount;
  var code;
  StreamSubscription<DocumentSnapshot> subscription;
  CollectionReference users = FirebaseFirestore.instance.collection(name);

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("Users" + "/" + name);

  bool finish = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }

  void _getBalance() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['points'];
          //ard = datasnapshot.data()['cardnumber'];
        });
      }
    });
  }

  @override
  void initState() {
    _getBalance();
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
    // : implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String member;
    _getBalance();
    if (name.length > 20) {}
    if (balance == null) {
      balance = 0;
    }
    if (balance <= 500) {
      member = "New Member";
    } else if (balance <= 2000) {
      member = "Bronze Member";
    } else if (balance <= 5000) {
      member = "Silver Member";
    } else if (balance <= 10000) {
      member = "Gold Member";
    } else {
      member = "Platinum Member";
    }
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text("Membership"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReserveList()),
            ),
          ),
        ),
        body: new Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: new Form(
                    key: formKey,
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                        new TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 5.0),
                            ),
                            hintText: " " + name,
                            hintStyle: TextStyle(
                                fontSize: 26.0,
                                color: Colors.white,
                                fontFamily: 'Raleway'),
                            prefixIcon: Icon(Icons.person_rounded,
                                size: 40, color: Colors.white),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                        new TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 5.0),
                            ),
                            hintText: " " + balance.toStringAsFixed(0),
                            hintStyle: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontFamily: 'Raleway'),
                            prefixIcon: Icon(Icons.emoji_events_rounded,
                                size: 40, color: Colors.white),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                        new TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 5.0),
                            ),
                            hintText: " " + member,
                            hintStyle: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontFamily: 'Raleway'),
                            prefixIcon: Icon(Icons.poll_rounded,
                                size: 40, color: Colors.white),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                        ExpansionTile(
                          title: Text(
                            "Membership Tiers",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                'New Member',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text('0 - 500 points'),
                                  subtitle: Text('\nNo benefits'),
                                )
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Bronze Member',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text('501 - 2000 points'),
                                  subtitle:
                                      Text('\n10% discount on parking fees'),
                                )
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Silver Member',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text('2001 - 5000 points'),
                                  subtitle: Text(
                                      '\n20% discount on parking fees\n10% discount on valet fees'),
                                )
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Gold Member',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text('5001 - 10000 points'),
                                  subtitle: Text(
                                      '\n25% discount on parking fees\n20% discount on valet\nFree welcome drink'),
                                )
                              ],
                            ),
                            ExpansionTile(
                              title: Text(
                                'Platinum Member',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text('10000+ points'),
                                  subtitle: Text(
                                      '\n50% discount on parking fees\nFree valet service on all locations\nFree welcome drink\nFree carwash service'),
                                )
                              ],
                            ),
                          ],
                        ),
                        /*   ExpansionTile(
                          title: Text(
                            "Terms and Conditions",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ExpansionTile(
                              title: Text(
                                'New Member',
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text('0 - 500 points'),
                                  subtitle: Text('10% off'),
                                )
                              ],
                            ),
                          ],
                       */ //),
                      ],
                    )))));
  }
}
