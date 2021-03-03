import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/gambirloc.dart';

class GambirRes extends StatefulWidget {
  @override
  GambirResState createState() {
    return new GambirResState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;
String place = "Gambir Station";
String valetstatus;
var time = DateTime.now().millisecondsSinceEpoch.toString();

class GambirResState extends State<GambirRes> {
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
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + "latest");

  final DocumentReference valetReference =
      FirebaseFirestore.instance.doc("Valet" + "/" + place);

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
    // "balance": "Flutter Developer"
    //};

    Map<String, String> data = <String, String>{
      "place": place,
      "hours": hours.toString(),
      "price": total.toString(),
      "valet": valetstatus,
    };

    bookingReference.set(data);

    documentReference.update({"balance": FieldValue.increment(total * -1)});

    documentReference.update({"points": FieldValue.increment(total / 1000)});

    placeReference.update({"payments": FieldValue.increment(total)});

    if (isSwitched == true) {
      placeReference.update({"quota": FieldValue.increment(1 * -1)});
      valetReference.update({"$name": hours.toString()});
    }
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GambirLoc()),
    );

    final form = formKey.currentState;
    form.reset();
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
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (total == null) {
      total = 0;
    }
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text("Reservation"),
        ),
        body: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 5.0),
                    ),
                    hintText: " " + balance.toString(),
                    hintStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontFamily: 'Raleway'),
                    prefixIcon: Icon(Icons.account_balance_wallet_rounded,
                        size: 40, color: Colors.white),
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(20.0)),
                new Text(
                  place + "\n",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                new Text(
                  "Rate per hour is Rp. " + price.toString() + "\n",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                new Text(
                  "Valet rate is Rp. " + valet.toString() + "\n",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Number of Hours"),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                      borderSide: BorderSide(color: Colors.blue, width: 5.0),
                    ),
                    hintText: "Total:      " + total.toString(),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
        ));
  }
}
