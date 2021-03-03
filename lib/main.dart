import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parkway/home.dart';
import 'package:parkway/login.dart';
import 'package:parkway/splash.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "splash": (BuildContext context) => SplashScreen(),
  // "/reserve": (BuildContext context) => ReserveList(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
        color: Colors.blueAccent,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Loading...",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                letterSpacing: 2.0,
                fontFamily: "Raleway",
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ],
        ));
  };
  //SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
  await Firebase.initializeApp();
  runApp(new MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.white,
          fontFamily: 'Raleway'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      navigatorKey: NavigationService().globalKey,
      routes: routes));
}
