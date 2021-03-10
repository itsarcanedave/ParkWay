import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/reserve.dart';
import 'package:flutter/services.dart';
import 'package:parkway/ctower.dart';
import 'package:parkway/citywalk.dart';
import 'package:parkway/gambir.dart';
import 'package:parkway/grandindo.dart';
import 'package:parkway/kokas.dart';
import 'package:parkway/pacific.dart';
import 'package:parkway/plazaindo.dart';
import 'package:parkway/plazasemanggi.dart';
import 'package:parkway/plazasenayan.dart';
import 'package:parkway/ritz.dart';
import 'package:parkway/sarinah.dart';
import 'package:parkway/sency.dart';
import 'package:parkway/sudirmanplaza.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() {
    return new SearchState();
  }
}

var time = DateTime.now().millisecondsSinceEpoch.toString();

class SearchState extends State<Search> {
  String searchname;
  String result = " ";

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  void _search() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (searchname.contains("City Tower") ||
          searchname.contains("city tower")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CTower())));
        result =
            "Location found!\nPlease wait while we redirect you to\nCity Tower Sudirman reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Citywalk") ||
          searchname.contains("citywalk")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Citywalk())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Citywalk Sudirman reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Gambir") ||
          searchname.contains("gambir")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Gambir())));
        result =
            "Location found!\nPlease wait while we redirect you to\nGambir Stationreservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Grand") || searchname.contains("grand")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => GrandIndo())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Grand Indonesia reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("kota") || searchname.contains("Kota")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Kokas())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Kota Kasablanka reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Pacific") ||
          searchname.contains("pacific")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Pacific())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Pacific Place reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Plaza Indonesia") ||
          searchname.contains("plaza indonesia")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => PlazaIndo())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Plaza Indonesia reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Plaza Semanggi") ||
          searchname.contains("plaza semanggi")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlazaSemanggi())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Plaza Semanggi reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Plaza Senayan") ||
          searchname.contains("plaza senayan")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlazaSenayan())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Plaza Senayan reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Ritz") || searchname.contains("ritz")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Ritz())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Ritz-Carlton reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Sarinah") ||
          searchname.contains("sarinah")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sarinah())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Sarinah reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("Senayan City") ||
          searchname.contains("senayan city")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sency())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Senayan City reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else if (searchname.contains("sudirman plaza") ||
          searchname.contains("Sudirman Plaza")) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SudirmanPlaza())));
        result =
            "Location found!\nPlease wait while we redirect you to\n Sudirman Plaza reservation page...";
        Timer(
            Duration(seconds: 4),
            () => setState(() {
                  result = " ";
                  form.reset();
                }));
      } else {
        result = "No location found!\nPlease double-check your keyword";
        form.reset();
      }
    }
  }

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            key: scaffoldKey,
            appBar: new AppBar(
              title: new Text("Search"),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.all(20.0)),
                        new TextFormField(
                          decoration: new InputDecoration(
                              labelText: "Enter location name"),
                          style: new TextStyle(fontSize: 18),
                          validator: (val) => val.contains(new RegExp(r'[0-9]'))
                              ? 'Invalid Amount!'
                              : null,
                          onSaved: (val) => setState(() {
                            searchname = val;
                            //hours = val;
                          }),
                        ),
                        new Padding(padding: const EdgeInsets.all(20.0)),
                        new Text(
                          result,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                        new RaisedButton.icon(
                          onPressed: _search,

                          //Timer(Duration(seconds: 5), () =>
                          //);
                          //},
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          label: Text(
                            "SEARCH LOCATION",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.blue,
                          ),
                          textColor: Colors.black,
                          splashColor: Colors.blue,
                          color: Colors.white,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
