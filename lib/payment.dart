import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/topup.dart';
import 'package:parkway/updatecard.dart';
import 'package:parkway/reserve.dart';
import 'package:parkway/QR.dart';

class Payment extends StatefulWidget {
  @override
  PaymentState createState() {
    return new PaymentState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

class PaymentState extends State<Payment> {
  String myText;
  var balance;
  var card;
  var points;
  StreamSubscription<DocumentSnapshot> subscription;
  CollectionReference users = FirebaseFirestore.instance.collection(name);

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("Users" + "/" + name);

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
    if (balance == null) {
      balance = 0;
    }
    String tempCard;
    if (card == 0) {
      tempCard = "No Card";
    } else {
      tempCard = card.toString();
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Wallet"),
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
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new TextField(
              enabled: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 5.0),
                ),
                hintText: " " + balance.toStringAsFixed(0),
                hintStyle: TextStyle(
                    fontSize: 25.0, color: Colors.white, fontFamily: 'Raleway'),
                prefixIcon: Icon(Icons.account_balance_wallet_rounded,
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
                  borderSide: BorderSide(color: Colors.blue, width: 5.0),
                ),
                hintText: " " + tempCard,
                hintStyle: TextStyle(
                    fontSize: 25.0, color: Colors.white, fontFamily: 'Raleway'),
                prefixIcon: Icon(Icons.credit_card_rounded,
                    size: 40, color: Colors.white),
              ),
            ),

            new Padding(
              padding: const EdgeInsets.all(10.0),
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
                  MaterialPageRoute(builder: (context) => QR()),
                );
              },
              child: new Text(
                "Top Up On-Site with QR Code",
                style: TextStyle(color: Colors.white, fontSize: 16),
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
                  MaterialPageRoute(builder: (context) => TopUp()),
                );
              },
              child: new Text(
                "Top Up with Card",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateCard()),
                );
              },
              child: new Text("Update Card",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            //  myText == null
            //           ? new Container()
            //          : new Text(
            //               myText,
            //               style: new TextStyle(fontSize: 20.0),
            //            )
          ],
        ),
      ),
    );
  }
}
