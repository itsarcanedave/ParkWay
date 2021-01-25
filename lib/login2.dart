import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed out");
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
        Positioned (
          bottom:10,
          child: RaisedButton(
            onPressed: () => _signIn()
                .then((User user ) => print(user))
                .catchError((e) => print(e)),
            child: new Text("GET STARTED"),
            color: Colors.white,

          ),),

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




              ],
            ),
          ),
        ),
      ],
    );
  }
}