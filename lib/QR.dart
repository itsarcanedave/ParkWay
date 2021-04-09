import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkway/payment.dart';

void main() {
  runApp(new QR());
}

class QR extends StatefulWidget {
  @override
  _QRState createState() => new _QRState();
}

class _QRState extends State<QR> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Top Up with QR Code"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Payment()),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.blueAccent,
                //onPressed: _add,
                onPressed: () async {
                  try {
                    String barcode = await BarcodeScanner.scan();
                    setState(() {
                      this.barcode = barcode;
                    });
                  } on PlatformException catch (error) {
                    if (error.code == BarcodeScanner.CameraAccessDenied) {
                      setState(() {
                        this.barcode =
                            'Please allow ParkWay to access your Camera!';
                      });
                    } else {
                      setState(() {
                        this.barcode = 'Error: $error';
                      });
                    }
                  }
                },

                child: new Text(
                  "SCAN QR CODE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Text(
                '$barcode',
                style: TextStyle(color: Colors.black, fontSize: 23),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
