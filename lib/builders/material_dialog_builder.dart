import 'package:flutter/material.dart';

class MaterialDialogBuilder {

  ///Returns a dialog depending on the [layout] specified.
  /// If the [layout] is [MaterialProgressDialogLayout.columnWithCircularProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] below the [message] [Text].
  /// If the [layout] is [MaterialProgressDialogLayout.columnReversedWithLinearProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] above the [message] [Text].
  /// If the [layout] is [MaterialProgressDialogLayout.rowWithCircularProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] by the left of the [message] [Text].
  /// If the [layout] is [MaterialProgressDialogLayout.columnWithLinearProgressIndicator], it returns a [ProgressDialog] with a [LinearProgressIndicator] below the [message] [Text].
  /// If the [layout] is [MaterialProgressDialogLayout.columnWithLinearProgressIndicator], it returns a [ProgressDialog] with a [LinearProgressIndicator] above the [message] [Text].
  /// If the [layout] is [MaterialProgressDialogLayout.justCircularProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] in the center.
  /// If the [layout] is [MaterialProgressDialogLayout.justLinearProgressIndicator], it returns a [ProgressDialog] with a [LinearProgressIndicator] in the center.
  /// If the [layout] is [MaterialProgressDialogLayout.overlayCircularProgressIndicator], it returns a [CircularProgressIndicator] in the center overlaying the context.
  /// If the [layout] is [MaterialProgressDialogLayout.overlayLinearProgressIndicator], it returns a [LinearProgressIndicator] in the center overlaying the context.
  static getBody(MaterialProgressDialogLayout layout, String messageString,
      TextStyle messageStyle) {
    Widget message;
    switch (layout) {
      case MaterialProgressDialogLayout.columnWithCircularProgressIndicator:
        message = _message(messageString, messageStyle, false);
        return _buildColumnCircularProgressDialog(message);
        break;
      case MaterialProgressDialogLayout
          .columnReveredWithCircularProgressIndicator:
        message = _message(messageString, messageStyle, false);
        return _buildColumnCircularProgressDialog(message, true);
        break;
      case MaterialProgressDialogLayout.rowWithCircularProgressIndicator:
        message = _message(messageString, messageStyle, true);
        return _buildRowCircularProgressDialog(message);
        break;
      case MaterialProgressDialogLayout.columnWithLinearProgressIndicator:
        message = _message(messageString, messageStyle, false);
        return _buildLinearProgressDialog(message);
        break;
      case MaterialProgressDialogLayout
          .columnReversedWithLinearProgressIndicator:
        message = _message(messageString, messageStyle, false);
        return _buildLinearProgressDialog(message, true);
        break;
      case MaterialProgressDialogLayout.justCircularProgressIndicator:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      case MaterialProgressDialogLayout.justLinearProgressIndicator:
        return Center(
          child: LinearProgressIndicator(),
        );
        break;
      case MaterialProgressDialogLayout.overlayCircularProgressIndicator:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      case MaterialProgressDialogLayout.overlayLinearProgressIndicator:
        return Center(
          child: LinearProgressIndicator(),
        );
        break;
    }
  }

  /// The [message] wrapped in a [Text] and the [Text] wrapped in [Expanded].
  static Widget _message(String message, messageStyle, isRow) {
    if (isRow) {
      return Expanded(
        child: Text(
          message ?? "",
          textAlign: TextAlign.left,
          overflow: TextOverflow.clip,
          style: messageStyle,
        ),
      );
    } else {
      return Text(
        message ?? "",
        textAlign: TextAlign.left,
        overflow: TextOverflow.clip,
        style: messageStyle,
      );
    }
  }

  static Widget _buildRowCircularProgressDialog(Widget message) {
    return Row(
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          width: 15,
        ),
        message
      ],
    );
  }

  static Widget _buildColumnCircularProgressDialog(Widget message,
      [reversed = false]) {
    var body = [
      message,
      SizedBox(
        height: 15,
      ),
      CircularProgressIndicator(),
    ];
    return Column(children: reversed ? body.reversed.toList() : body);
  }

  static Widget _buildLinearProgressDialog(Widget message, [reversed = false]) {
    var body = [
      message,
      SizedBox(
        height: 15,
      ),
      LinearProgressIndicator(),
    ];
    return Column(children: reversed ? body.reversed.toList() : body);
  }

  /// Returns the [shape] passed if it is not null else it returns a fixed shape RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)).
  static getShape(shape) => shape == null
      ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
      : shape;

  /// Returns the [contentPadding] passed if it is not null else it  returns a fixed padding EdgeInsets.symmetric(vertical: 23, horizontal: 25).
  static getPadding(contentPadding) => contentPadding == null
      ? EdgeInsets.symmetric(vertical: 23, horizontal: 25)
      : contentPadding;
}

/// The material progress dialog layouts.
enum MaterialProgressDialogLayout {
  columnWithCircularProgressIndicator,
  columnReveredWithCircularProgressIndicator,
  rowWithCircularProgressIndicator,
  columnWithLinearProgressIndicator,
  columnReversedWithLinearProgressIndicator,
  justCircularProgressIndicator,
  justLinearProgressIndicator,
  overlayCircularProgressIndicator,
  overlayLinearProgressIndicator
}