import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/rating.dart';

class Outstanding extends StatefulWidget {
  @override
  OutstandingState createState() {
    return new OutstandingState();
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

class OutstandingState extends State<Outstanding> {
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

    documentReference.update({"balance": FieldValue.increment(50000 * -1)});
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
    //placeReference
    //   .update({"balance": FieldValue.increment(total*-1)});
    placeReference.update({"payments": FieldValue.increment(50000)});
    //placeReference.update({"payments": FieldValue.increment(total)});
  }

  void _getBalance() {

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
   // Navigator.push(
  //    context,
 //     MaterialPageRoute(builder: (context) => History()),
 //   );
    _getBalance();
    final form = formKey.currentState;
    form.reset();
    _update();
    Navigator.push(
           context,
            MaterialPageRoute(builder: (context) => Rating()),
           );
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
          title: new Text("Outstanding Charges"),
            leading: IconButton(
              icon: Icon(Icons.attach_money_rounded, color: Colors.white),
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
                      uplace + "\n",
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "You have exceeded\nthe duration of your reservation\n",
                        textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "A penalty of Rp. 50.000\nwill be deducted from your balance",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16, fontWeight: FontWeight.bold),
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
                        'CONFIRM AND CONTINUE',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.local_parking_rounded,
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

                    ),

                  ],
                ),
              ),
            )));
  }
}
