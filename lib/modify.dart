import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/history.dart';

class Modify extends StatefulWidget {
  @override
  ModifyState createState() {
    return new ModifyState();
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
var time = DateTime.now().millisecondsSinceEpoch.toString();

class ModifyState extends State<Modify> {
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

    Map<String, String> data = <String, String>{
      "hours": hours.toString(),
      "price": total.toString(),
      "valet": valetstatus,
    };

    bookingReference.update(data);

    documentReference.update({"balance": FieldValue.increment(uprice)});
    documentReference.update({"balance": FieldValue.increment(total * -1)});

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
    //placeReference
    //   .update({"balance": FieldValue.increment(total*-1)});
    placeReference.update({"payments": FieldValue.increment(uprice * -1)});
    placeReference.update({"payments": FieldValue.increment(total)});
  }

  void _getBalance() {
    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          uhours = int.parse(datasnapshot.data()['hours']);
          uplace = datasnapshot.data()['place'];
          uprice = int.parse(datasnapshot.data()['price']);
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
      MaterialPageRoute(builder: (context) => History()),
    );
    _getBalance();
    final form = formKey.currentState;
    form.reset();
    _update();
  }

  @override
  void initState() {
    _getBalance();
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
          title: new Text("Modify Reservation"),
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
                    new Text(
                      "Valet is " + uvalet + "\n",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "Special rates applied when modifying a reservation" +
                          "\n" +
                          "Rate per hour is Rp. " +
                          uratepark.toStringAsFixed(0) +
                          "\n" +
                          "Valet rate is Rp. " +
                          urateval.toStringAsFixed(0) +
                          "\n",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    new TextFormField(
                      decoration:
                          new InputDecoration(labelText: "Number of Hours"),
                      style: new TextStyle(fontSize: 18),
                      validator: (val) => val.contains(new RegExp(r'[A-Z]'))
                          ? 'Invalid Amount!'
                          : null,
                      onSaved: (val) => setState(() {
                        hours = val;
                      }),
                    ),
                    new Padding(padding: const EdgeInsets.all(20.0)),
                    new Text(
                      "Valet",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    new Switch(
                        activeColor: Colors.blue,
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        }),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new RaisedButton.icon(
                      onPressed: _calculate,

                      //Timer(Duration(seconds: 5), () =>
                      //);
                      //},
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      label: Text(
                        "CALCULATE PARKING COSTS",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.calculate_rounded,
                        color: Colors.blue,
                      ),
                      textColor: Colors.black,
                      splashColor: Colors.blue,
                      color: Colors.white,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 5.0),
                        ),
                        hintText: "Total:      " + total.toStringAsFixed(0),
                        hintStyle: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontFamily: 'Raleway'),
                        //  prefixIcon: Icon(Icons.shopping_cart_rounded,
                        //     size: 40, color: Colors.white),
                      ),
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
                        'CONFIRM AND RESERVE',
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
