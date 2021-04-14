import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkway/outstanding.dart';
import 'package:parkway/rating.dart';

class Timer extends StatefulWidget {
  @override
  TimerState createState() => TimerState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final name = user.displayName;

class TimerState extends State<Timer> with TickerProviderStateMixin {
  AnimationController animationController;
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
  String place;
  String uplace;
  String tracker;
  String message;
  var uhours;
  var uprice;
  var uratepark;
  final DocumentReference documentReference =
  FirebaseFirestore.instance.doc("Users" + "/" + name);


  final DocumentReference bookingReference =
  FirebaseFirestore.instance.doc(
      "Users" + "/" + name + "/" + "Bookings" + "/" + "latest");

  final DocumentReference historyReference = FirebaseFirestore.instance
      .doc("Users" + "/" + name + "/" + "Bookings" + "/" + "latest");
  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    //tracker = duration.inMinutes.toString();


    if (duration.inMinutes > 60) {

      tracker = duration.toString();
      return '${duration.inHours}:${(duration.inMinutes - 60 * (uhours - 1))}:${(duration.inSeconds % 60)
          .toString()
          .padLeft(2, '0')}';

    } else {

      return '${duration.inHours}:${duration.inMinutes}:${(duration.inSeconds % 60)
          .toString()
          .padLeft(2, '0')}';
    }

  }

  void _getBalance() {


    historyReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          uhours = int.parse(datasnapshot.data()['hours']);
          uplace = datasnapshot.data()['place'];
          //uprice = int.parse(datasnapshot.data()['price']);
          uvalet = datasnapshot.data()['valet'];
          animationController =
              AnimationController(vsync: this, duration: Duration(hours: uhours));
          animationController.reverse(
              from: animationController.value == 0.0
                  ? 1.0
                  : animationController.value);

        });
      }
    });

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          balance = datasnapshot.data()['balance'];
          //ard = datasnapshot.data()['cardnumber'];
        });
      }
    });


  }

  @override
  void initState() {
    super.initState();
    _getBalance();

    //animationController.stop();
  }

  String trackcheck() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        Duration duration =
            animationController.duration * animationController.value;
        tracker = duration.inSeconds.toString();

        if (tracker == 0) {
          message = "You have exceeded the duration of your reservation\nClick the button below to end your reservation\nand settle outstanding charges\n";
        } else {
          message = "You have no outstanding charges\nClick the button below to end your reservation\n";
        }
      });});
      return tracker;
     }

  _boolcheckdur() {
    if (tracker == 0) {
      return (() => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Outstanding()),
      ));
    } else {
      return (() => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Rating()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    //_getBalance();
    trackcheck();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsets.all(8.0),

        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                              painter: TimerPainter(
                                  animation: animationController,
                                  backgroundColor: Colors.redAccent,
                                  color: Theme.of(context).accentColor),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Your Reservation",
                              style: const TextStyle(color: Colors.white,
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            AnimatedBuilder(
                                animation: animationController,
                                builder: (_, Widget child) {
                                  return Text(
                                    timerString,
                                    style: const TextStyle(color: Colors.white,
                                        fontSize: 85, fontWeight: FontWeight.bold),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    message,
                  textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  new RaisedButton.icon(
                    onPressed: _boolcheckdur(),
                      //   Navigator.push(
                      //    context,
                      //   MaterialPageRoute(builder: (context) => TopUp()),
                      //  );

                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      'END RESERVATION',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.white,
                    ),
                    textColor: Colors.black,
                    splashColor: Colors.blue,
                    color: Colors.deepOrangeAccent,
                  ),


                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  //FloatingActionButton(
                   /* child: AnimatedBuilder(
                        animation: animationController,
                        builder: (_, Widget child) {
                          return Icon(animationController.isAnimating
                              ? Icons.pause
                              : Icons.play_arrow);
                        }),
                    onPressed: () {
                    /*  if (animationController.isAnimating) {
                        animationController.stop();
                      } else {
                        animationController.reverse(
                            from: animationController.value == 0.0
                                ? 1.0
                                : animationController.value);
                      }
                 */   },
                */ // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;


  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);

    // : implement paint
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}