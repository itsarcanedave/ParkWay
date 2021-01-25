import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:parkway/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(LoginScreen());

}

// ignore: camel_case_types
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParkWay',
      theme: new ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.black, accentColor: Colors.white,
      ),
      home: new loginScreen(),
    );
  }
}

class NavigationService {
  final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Route Route) {
    return globalKey.currentState.push(Route);
  }
}


class loginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<User> _signIn() async {
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
    await account.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    print("User Name : ${user.displayName}");
    NavigationService().navigateTo(
      MaterialPageRoute(builder:
          (context) => HomeScreen(),
      ),);
    return user;

  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }


  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Image.asset(
          "assets/landing2.png",
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          fit: BoxFit.cover,
        ),




        Scaffold(

          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            title: new Text("ParkWay"),
          ),
          body: new Padding(
            padding: const EdgeInsets.all(20.0),

            child: new Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                  child: Text(
                      "",
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ), FlatButton(
                  child: Text(
                    "",
                  ),
                  onPressed: () {},
                ),




               new  RaisedButton.icon(
                 onPressed: () {
                   _signIn();

                   Timer(Duration(seconds: 5), () =>
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => HomeScreen()),
                   ));
                 },

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('GET STARTED',
                    style: TextStyle(color: Colors.blue),),
                  icon: Icon(Icons.local_parking_rounded, color:Colors.blue,),
                  textColor: Colors.black,
                  splashColor: Colors.blue,
                  color: Colors.white,),

              ],
            ),
          ),
        ),
      ],
    );
  }
}