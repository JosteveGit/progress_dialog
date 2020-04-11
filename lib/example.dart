import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progressdialog/progressdialog.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          ProgressDialog dialog = ProgressDialog(context: context)..show(
              message: "Please wait...",
              title: "Fetching Data",
              centerTile: true,
              titleStyle: TextStyle(fontSize: 40, color: Colors.orange[900]),
              messageStyle: TextStyle(fontSize: 20, color: Colors.green)
          );
          Timer(Duration(seconds: 10), (){dialog.dismiss();});
        },
      ),
    );
  }
}