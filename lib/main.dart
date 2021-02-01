
import 'package:flutter/material.dart';
import 'package:parkway/splash.dart';
import 'package:parkway/login.dart';
import 'package:parkway/home.dart';
import 'package:parkway/intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parkway/test.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/login": (BuildContext context) => LoginScreen(), "splash": (BuildContext context) => SplashScreen()
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
      theme:
      ThemeData(primaryColor: Colors.blue, accentColor: Colors.white,  fontFamily: 'Raleway' ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      navigatorKey: NavigationService().globalKey,
      routes: routes));
}
