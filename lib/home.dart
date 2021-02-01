import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkway/login.dart';
import 'package:parkway/map.dart';
import 'package:parkway/reserve.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getCurrentLocation();
  runApp(HomeScreen());
}

void getCurrentLocation() async {
  final Position position = await Geolocator()
      .getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      )
      .catchError((err) => print(err));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParkWay',
      theme: new ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: new HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User user = auth.currentUser;
    final name = user.displayName;

    return new Stack(
      children: <Widget>[
        Image.asset(
          "assets/home1.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            title: new Text("Welcome, " + name + "!"),
          ),
          body: Column(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(

                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(

                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.map, color: Colors.white, size: 50),
                            Text(
                              'MAP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPage()),
                          );
                        },
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.book_rounded,
                                color: Colors.white, size: 50),
                            Text(
                              'DASHBOARD',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReserveList()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                child: Text(
                  "",
                ),
                onPressed: () {},
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        color: Colors.deepOrangeAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.watch_later_rounded,
                                color: Colors.white, size: 50),
                            Text(
                              'HISTORY',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        color: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.exit_to_app_rounded,
                                color: Colors.white, size: 50),
                            Text(
                              'SIGN OUT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _signOut() async {
                            await auth.signOut();
                          }

                          _signOut();
                          final GoogleSignIn googleSignIn = new GoogleSignIn();
                          googleSignIn.signOut();
                          print("User Signed out");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
