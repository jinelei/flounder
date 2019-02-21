import 'package:flounder/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class ScanQR extends StatefulWidget {
  @override
  State createState() {
    return _MyScanState();
  }
}

class _MyScanState extends State<ScanQR> {
  String scanResult = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Scan'),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.camera_enhance,
                color: Colors.white,
              ),
              onPressed: () {
                scan();
              },
            )
          ],
        ),
        drawer: Utils.gengerateDrawer(context),
        body: Builder(
          builder: (BuildContext c) {
            final TapGestureRecognizer recognizer = new TapGestureRecognizer();
            recognizer.onTap = () {
              final SnackBar snackBar = SnackBar(
                content: Text('$scanResult'),
                duration: Duration(milliseconds: 500),
              );
              Scaffold.of(c).showSnackBar(snackBar);
            };
            return new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                    child: RaisedButton(
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        splashColor: Colors.blueGrey,
                        onPressed: scan,
                        child: const Text('开始扫描')),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: RichText(
                          text: TextSpan(
                              text: 'result: ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                              text: '$scanResult',
                              style: TextStyle(color: Colors.blueAccent),
                              recognizer: recognizer,
                            ),
                          ]))),
                ],
              ),
            );
          },
        ));
  }

  Future scan() async {
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        return this.scanResult = scanResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          return this.scanResult =
              'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.scanResult = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() => this.scanResult =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.scanResult = 'Unknown error: $e');
    }
  }
}
