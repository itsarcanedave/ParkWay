import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UpdateCard extends StatefulWidget {
  @override
  UpdateCardState createState() {
    return new UpdateCardState();
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

class UpdateCardState extends State<UpdateCard> {
  String myText;

  var topup;
  var card;

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

  void _process() {
    // Map<String, String> data = <String, String>{
    // "balance": ""
    //}; num
    Map<String, num> data = <String, num>{
      "cardnumber": int.parse(card),
    };
    documentReference.update(data);

    // documentReference.update({"balance": FieldValue.increment(int.parse(amount))});
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          card = datasnapshot.data()['cardnumber'];
        });
      }
    });
  }

  void _getBalance() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          // balance = datasnapshot.data()['balance'];
          card = datasnapshot.data()['cardnumber'];
        });
      }
      if (datasnapshot.exists == false) {
        Map<String, num> data = <String, num>{
          //"balance": 0,
          "cardnumber": 0,
        };
        documentReference.setData(data);
        setState(() {
          card = datasnapshot.data()['cardnumber'];
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

  void performTopup() {
    _process();
    final snackbar = new SnackBar(
        content: new Text("Successfully updated your card number to $card"));
    scaffoldKey.currentState.showSnackBar(snackbar);
    final form = formKey.currentState;
    form.reset();
  }

  @override
  void initState() {
    // : implement initState
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
    _getBalance();
    String tempCard;
    if (card == 0) {
      tempCard = "No Card";
    } else {
      tempCard = card.toString();
    }

    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text("Update Card"),
        ),
        body: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
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
                        fontSize: 25.0,
                        color: Colors.white,
                        fontFamily: 'Raleway'),
                    prefixIcon: Icon(Icons.credit_card_rounded,
                        size: 40, color: Colors.white),
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Bank Name"),
                  style: new TextStyle(fontSize: 18),
                  validator: (val) => !val.contains(new RegExp(r'[A-Z]'))
                      ? 'Invalid Bank Name!'
                      : null,
                  //onSaved: (val) => amount = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Card Number"),
                  style: new TextStyle(fontSize: 18),
                  validator: (val) => val.contains(new RegExp(r'[A-Z]'))
                      ? 'Invalid Card Number!'
                      : null,
                  onSaved: (val) => card = val,
                ),
                new TextFormField(
                  decoration:
                      new InputDecoration(labelText: "Authentication Code"),
                  validator: (val) => val.length < 6 ? 'Invalid Code!' : null,
                  style: new TextStyle(fontSize: 18),
                  onSaved: (val) => code = val,
                  obscureText: true,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: new Text(
                    "UPDATE CARD",
                    style: new TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: _topup,
                )
              ],
            ),
          ),
        ));
  }
}
