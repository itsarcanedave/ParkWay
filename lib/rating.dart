import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/ratingwall.dart';

//: Erase completed reservations
class Rating extends StatefulWidget {
  @override
  RatingState createState() {
    return new RatingState();
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
var counter;
var time = DateTime.now().millisecondsSinceEpoch.toString();

class RatingState extends State<Rating> {
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
    final DocumentReference placeReference =
        FirebaseFirestore.instance.doc("Places" + "/" + uplace);
    placeReference.update({"counter": FieldValue.increment(1)});
    placeReference.get().then((datasnapshot) {
      setState(() {
        rating = datasnapshot.data()['rating'];
        counter = datasnapshot.data()['counter'];
        var newRating = rating + _value;
        placeReference.update({"rating": newRating});
      });
    });

    //placeReference
    //   .update({"balance": FieldValue.increment(total*-1)});
    // placeReference.update({"payments": FieldValue.increment(50000)});
    //placeReference.update({"payments": FieldValue.increment(total)});
  }

  void ratingProc() {
    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          uhours = int.parse(datasnapshot.data()['hours']);
          uplace = datasnapshot.data()['place'];
          uprice = datasnapshot.data()['price'];
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

  void ratingFunc() {
    final DocumentReference placeReference =
        FirebaseFirestore.instance.doc("Places" + "/" + uplace);
    placeReference.update({"space": FieldValue.increment(1)});
    placeReference.get().then((datasnapshot) {
      setState(() {
        rating = datasnapshot.data()['rating'];
        counter = datasnapshot.data()['counter'];
      });
    });
  }

  void _topup() {
    performTopup();
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
    ratingFunc();
    _update();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingWall()),
    );
  }

  @override
  void initState() {
    ratingProc();
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
    ratingProc();
    ratingFunc();
    uratepark = 2000;
    0;




    if (total == null) {
      total = 0;
    }
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
            backgroundColor: Colors.blue,
            title: new Text("Location Rating"),
            leading: IconButton(
              icon: Icon(Icons.star_rounded, color: Colors.white),
              onPressed: () {
                //Navigator.pop(context);
              },)
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
                      uplace +
                          "\n" +
                          "You reserved for " +
                          uhours.toString() +
                          " hours" "\n" +
                          "Rp. " +
                          uprice.substring(0, uprice.length - 2) +
                          " was paid" +
                          "\n",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "Drag the slider below to rate this location",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.blueAccent,
                        inactiveTrackColor: Colors.red[100],
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 6.0,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        thumbColor: Colors.blueAccent,
                        overlayColor: Colors.red.withAlpha(32),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Colors.white,
                        inactiveTickMarkColor: Colors.red[100],
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.blueAccent,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: _value,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: '$_value',
                        onChanged: (value) {
                          setState(
                                () {
                              _value = value;
                            },
                          );
                        },
                      ),
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
                        'SUBMIT RATING',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.blue,
                      color: Colors.deepOrangeAccent,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new TextField(
                        enabled: false),

                  ],
                ),
              ),
            )));
  }
}
