#Example
```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simpleprogressdialog/cupertino_dialog_builder.dart';
import 'package:simpleprogressdialog/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {

  ProgressDialog dialog = ProgressDialog(barrierDismissible: false, elevation: 10.0);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  dialog.showMaterial(
                    message: "The message",
                    title: "The title",
                    centerTitle: true,
                    layout: MaterialProgressDialogLayout.columnReveredWithCircularProgressIndicator,
                    messageStyle: TextStyle(color: Colors.green[900]),
                  );
                  dismiss();
                },
                child: Text("Show Material Dialog"),
              ),
              FlatButton(
                onPressed: () {
                  dialog.showCupertino(
                    message: "The message",
                    title: "The title",
                    centerTitle: true,
                    backgroundColor: Colors.blue,
                    layout: CupertinoProgressDialogLayout.columnWithCircularActivityIndicator,
                    messageStyle: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
                    titleStyle: TextStyle(
                      color: Colors.red[900],
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  );
                  dismiss();
                },
                child: Text("Show Cupertino Dialog"),
              ),
              FlatButton(
                onPressed: () {
                  dialog.showAdaptive(
                    message: "The message",
                    title: "The title",
                    centerTitle: true,
                    layoutForIOS: CupertinoProgressDialogLayout.columnReveredWithCircularActivityIndicator,
                    layoutForAndroid: MaterialProgressDialogLayout.columnReveredWithCircularProgressIndicator,
                    messageStyle: TextStyle(color: Colors.green[900], fontFamily: 'Montserrat'),
                    titleStyle: TextStyle(
                      color: Colors.green[900],
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                    ),
                  );
                  dismiss();
                },
                child: Text("Show Adaptive Dialog"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dismiss(){
    Timer(Duration(seconds: 3), (){dialog.dismiss();});
  }
}
```