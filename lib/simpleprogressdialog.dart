import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino_dialog_builder.dart';
import 'dialog_builder.dart';
import 'material_dialog_builder.dart';

///A Customizable Progress Dialog.
class ProgressDialog {

  ///The context of the dialog :CANNOT BE NULL.
  BuildContext context;

  ///If true, the dialog won't be dismissed by tapping anywhere outside. Invoking the [dismiss] method will be the only way of dismissing the dialog.
  final bool barrierDismissible;

  ///From showDialog in [Dialog].
  final bool useRootNavigator;

  ///From showDialog in [Dialog].
  final RouteSettings routeSettings;

  ///The shape of the dialog can be StadiumBorder or RoundedRectangleBorder.
  final ShapeBorder shape;

  ///The elevation in [Dialog]. The elevation will be overwritten if the layout is an "overlay" layout.
  final double elevation;

  ///[_canPop] is true when the dialog has been shown, and remains false if the dialog has not been shown.
  ///It helps in detecting if the dialog can be dismissed.
  bool _canPop = false;

  ProgressDialog(
      {this.context,
        this.barrierDismissible = true,
        this.useRootNavigator = true,
        this.routeSettings,
        this.shape,
        this.elevation = 2});

  ///Method to show a material dialog with parameters; [title], [message], [layout], [centerTile], [titleStyle], [messageStyle], [contentPadding], [backGroundColor].
  ///If [title] is null, the space for [title] text will also be gone.
  ///[message] cannot be null.
  ///[layout] defines what type of progress indicator is shown and how it is displayed.
  ///if [centerTile] is true, then [title] will be positioned at the center on the horizontal axis.
  ///[titleStyle] styles the title.
  ///[messageStyle] styles the message.
  ///[contentPadding] is from [SimpleDialog] to add some space between the content and the dialog.
  ///[backGroundColor] : to change the background color of the dialog.
  void showMaterial(
      {String title,
        String message,
        MaterialProgressDialogLayout layout = MaterialProgressDialogLayout.rowWithCircularProgressIndicator,
        bool centerTitle = false,
        TextStyle titleStyle,
        TextStyle messageStyle,
        EdgeInsets contentPadding,
        Color backgroundColor = Colors.white}) {
    assert(context != null);
    assert(useRootNavigator != null);
    assert(_canPop == false);
    if (_canShow()) {
      _canPop = true;
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (context) {
          return SimpleDialog(
            backgroundColor:
            DialogBuilder.getBackgroundColor(backgroundColor, layout),
            title: DialogBuilder.getTitle(title, centerTitle, titleStyle, layout),
            shape: MaterialDialogBuilder.getShape(shape),
            elevation: DialogBuilder.getElevation(elevation, layout),
            contentPadding: MaterialDialogBuilder.getPadding(contentPadding),
            children: <Widget>[
              MaterialDialogBuilder.getBody(layout, message, messageStyle)
            ],
          );
        },
      );
    } else {
      dismiss();
      throw new Exception("Attempt to show more than one dialog at a time. Consider dimissing the a showing dialog before showing another.");
    }
  }


  ///Method to show a cupertino dialog with parameters; [title], [message], [layout], [centerTile], [titleStyle], [messageStyle], [contentPadding], [backGroundColor].
  ///If [title] is null, the space for [title] text will also be gone.
  ///[message] cannot be null.
  ///[layout] defines what type of progress indicator is shown and how it is displayed.
  ///if [centerTile] is true, then [title] will be positioned at the center on the horizontal axis.
  ///[titleStyle] styles the title.
  ///[messageStyle] styles the message.
  ///[contentPadding] is from [SimpleDialog] to add some space between the content and the dialog.
  ///[backGroundColor] : to change the background color of the dialog.
  void showCupertino(
      {String title,
        String message,
        CupertinoProgressDialogLayout layout =
            CupertinoProgressDialogLayout.rowWithCircularActivityIndicator,
        bool centerTitle = true,
        TextStyle titleStyle,
        TextStyle messageStyle,
        EdgeInsets contentPadding,
        Color backgroundColor = Colors.white}) {
    assert(context != null);
    assert(useRootNavigator != null);
    if (_canShow()) {
      _canPop = true;
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor:
            DialogBuilder.getBackgroundColor(backgroundColor, layout),
            shape: CupertinoDialogBuilder.getShape(shape),
            title: DialogBuilder.getTitle(title, centerTitle, titleStyle, layout),
            contentPadding: CupertinoDialogBuilder.getPadding(contentPadding),
            elevation: DialogBuilder.getElevation(elevation, layout),
            children: [
              CupertinoDialogBuilder.getBody(layout, message, messageStyle),
            ],
          );
        },
      );
    } else {
      dismiss();
      throw new Exception("Attempt to show more than one dialog at a time. Consider dimissing the a showing dialog before showing another.");
    }
  }

  bool _canShow() => !_canPop;

  ///Method to show an adaptive(shows a material dialog on Android and a cupertino dialog on iOS) dialog with parameters; [title], [message], [layout], [centerTile], [titleStyle], [messageStyle], [contentPadding], [backGroundColor].
  ///If [title] is null, the space for [title] text will also be gone.
  ///[message] cannot be null.
  ///[layout] defines what type of progress indicator is shown and how it is displayed.
  ///if [centerTile] is true, then [title] will be positioned at the center on the horizontal axis.
  ///[titleStyle] styles the title.
  ///[messageStyle] styles the message.
  ///[contentPadding] is from [SimpleDialog] to add some space between the content and the dialog.
  ///[backGroundColor] : to change the background color of the dialog.
  void showAdaptive(
      {String title,
        String message,
        CupertinoProgressDialogLayout layoutForIOS =
            CupertinoProgressDialogLayout.rowWithCircularActivityIndicator,
        MaterialProgressDialogLayout layoutForAndroid =
            MaterialProgressDialogLayout.rowWithCircularProgressIndicator,
        bool centerTitle,
        TextStyle titleStyle,
        TextStyle messageStyle,
        EdgeInsets contentPadding,
        Color backgroundColor = Colors.white}) {
    if (Platform.isIOS) {
      return showCupertino(
          title: title,
          message: message,
          layout: layoutForIOS,
          centerTitle: centerTitle == null ? true : centerTitle,
          titleStyle: titleStyle,
          messageStyle: messageStyle,
          contentPadding: contentPadding,
          backgroundColor: backgroundColor);
    }
    return showMaterial(
        title: title,
        message: message,
        layout: layoutForAndroid,
        centerTitle: centerTitle,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor);
  }

  ///Dismisses the dialog if it is shown.
  void dismiss() {
    if (_canPop) {
      Navigator.pop(context);
      _canPop = false;
      return;
    }
    throw new Exception("Attempt to dismiss a ProgressDialog that has not been shown. Consider showing a dialog before dimissing.");
  }
}

