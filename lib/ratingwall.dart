import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/home.dart';

//: Erase completed reservations
class RatingWall extends StatefulWidget {
  @override
  RatingWallState createState() {
    return new RatingWallState();
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
var rating;

var time = DateTime.now().millisecondsSinceEpoch.toString();

class RatingWallState extends State<RatingWall> {
  double _value = 10;
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

  void _process() {
    // Map<String, String> data = <String, String>{
    // "balance": ""
    //};

    //documentReference.update({"balance": FieldValue.increment(50000 * -1)});
    //documentReference.update({"balance": FieldValue.increment(total * -1)});

    // documentReference
    //   .update({"points": FieldValue.increment(total/1000)});

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['balance'];
        });
      }
    });
  }

  void _update() {
    //final DocumentReference placeReference =
    // FirebaseFirestore.instance.doc("Places" + "/" + uplace);
    //placeReference.get().then((datasnapshot) {
    // setState(() {
    //  rating = datasnapshot.data()['rating'];
    // counter = datasnapshot.data()['counter'];
    // rating = rating / counter;

    // });
    // });

    //placeReference
    //   .update({"balance": FieldValue.increment(total*-1)});
    // placeReference.update({"payments": FieldValue.increment(50000)});
    //placeReference.update({"payments": FieldValue.increment(total)});
  }

  void _getBalance() {
    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          uhours = int.parse(datasnapshot.data()['hours']);
          uplace = datasnapshot.data()['place'];

          uvalet = datasnapshot.data()['valet'];
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
    _update();
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
    //_process();
    // Navigator.push(
    //    context,
    //     MaterialPageRoute(builder: (context) => History()),
    //   );
    //_getBalance();
    final form = formKey.currentState;
    form.reset();
    _update();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  void initState() {
    _getBalance();
    place = uplace;
    super.initState();
    final DocumentReference bookingReference = FirebaseFirestore.instance
        .doc("Users" + "/" + name + "/" + "Bookings" + "/" + "latest");
    bookingReference.delete();
    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          uplace = datasnapshot.data()['place'];

          uvalet = datasnapshot.data()['valet'];
        });
      }
    });
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
            title: new Text("Thank You!"),
            leading: IconButton(
              icon: Icon(Icons.star_rounded, color: Colors.white),
              onPressed: () {
                //Navigator.pop(context);
              },
            )),
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
                      "Thank you for your feedback!" + "\n",
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "We hope to see you again on your next reservation!" "\n",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
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
                        'GO HOME',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.blue,
                      color: Colors.deepOrangeAccent,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new TextField(enabled: false),
                  ],
                ),
              ),
            )));
  }
}
