import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/topup.dart';

class PacificLoc extends StatefulWidget {
  @override
  PacificLocState createState() {
    return new PacificLocState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;
String place = "Pacific Place";
String valetstatus;
var time = DateTime.now().millisecondsSinceEpoch.toString();

class PacificLocState extends State<PacificLoc> {
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
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + time);

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
    final snackbar = new SnackBar(
      content: new Text("Successfully added $amount to your balance"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    final form = formKey.currentState;
    form.reset();
  }

  @override
  void initState() {
    // TODO: implement initState
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
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _getBalance();
    if (total == null) {
      total = 0;
    }
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Choose Parking Space"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Text(
              "Pacific Place\n",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
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
                //   Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => TopUp()),
                //  );
              },
              child: new Text(
                "Lower Ground",
                style: TextStyle(color: Colors.white, fontSize: 18),
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
                //   Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => TopUp()),
                //  );
              },
              child: new Text(
                "Ground Floor",
                style: TextStyle(color: Colors.white, fontSize: 18),
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
                //   Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => TopUp()),
                //  );
              },
              child: new Text(
                "Upper Ground",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
