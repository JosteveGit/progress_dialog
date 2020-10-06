import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDialogBuilder {

  ///Returns a dialog depending on the [layout] specified.
  /// If the [layout] is [CupertinoProgressDialogLayout.columnWithCircularActivityIndicator], it returns a [ProgressDialog] with a [CupertinoActivityIndicator] below the [message] [Text].
  /// If the [layout] is [CupertinoProgressDialogLayout.columnReveredWithCircularActivityIndicator], it returns a [ProgressDialog] with a [CupertinoActivityIndicator] above the [message] [Text].
  /// If the [layout] is [CupertinoProgressDialogLayout.rowWithCircularActivityIndicator], it returns a [ProgressDialog] with a [CupertinoActivityIndicator] by the left of the [message] [Text].
  /// If the [layout] is [CupertinoProgressDialogLayout.justCircularActivityIndicator], it returns a [ProgressDialog] with a [CupertinoActivityIndicator] in the center.
  /// If the [layout] is [CupertinoProgressDialogLayout.overlayCircularActivityIndicator], it returns a [CupertinoActivityIndicator] in the center overlaying the context.
  static getBody(CupertinoProgressDialogLayout layout, String messageString,
      TextStyle messageStyle) {
    Widget message = _message(messageString, messageStyle, false);
    switch (layout) {
      case CupertinoProgressDialogLayout.rowWithCircularActivityIndicator:
        message = _message(messageString, messageStyle, true);
        return _buildRowCircularActivityDialog(message);
        break;
      case CupertinoProgressDialogLayout.columnWithCircularActivityIndicator:
        return _buildColumnCircularActivityDialog(message);
        break;
      case CupertinoProgressDialogLayout
          .columnReveredWithCircularActivityIndicator:
        return _buildColumnCircularActivityDialog(message, true);
        break;
      case CupertinoProgressDialogLayout.justCircularActivityIndicator:
        return Center(
          child: _indicator,
        );
        break;
      case CupertinoProgressDialogLayout.overlayCircularActivityIndicator:
        return Center(
          child: _indicator,
        );
        break;
    }
  }

  /// Returns the [shape] passed if it is not null else it returns a fixed shape RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)).
  static getShape(shape) => shape == null
      ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))
      : shape;

  /// Returns the [contentPadding] passed if it is not null else it  returns a fixed padding EdgeInsets.symmetric(vertical: 23, horizontal: 15).
  static getPadding(contentPadding) => contentPadding == null
      ? EdgeInsets.symmetric(vertical: 23, horizontal: 15)
      : contentPadding;

  static var _indicator = CupertinoActivityIndicator(
    radius: 13,
  );

  static Widget _buildRowCircularActivityDialog(Widget message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 15,
        ),
        _indicator,
        SizedBox(
          width: 15,
        ),
        message ?? ""
      ],
    );
  }

  static Widget _buildColumnCircularActivityDialog(Widget message,
      [reversed = false]) {
    var body = [
      message,
      SizedBox(
        height: 15,
      ),
      _indicator
    ];
    return Column(children: reversed ? body.reversed.toList() : body);
  }

  /// The [message] wrapped in a [Text] and the [Text] wrapped in [Expanded].
  static Widget _message(String message, messageStyle, isRow) {
    if (isRow) {
      return Expanded(
        child: Text(
          message,
          textAlign: TextAlign.left,
          overflow: TextOverflow.clip,
          style: messageStyle,
        ),
      );
    } else {
      return Text(
        message,
        textAlign: TextAlign.left,
        overflow: TextOverflow.clip,
        style: messageStyle,
      );
    }
  }
}

/// The cupertino progress dialog layouts.
enum CupertinoProgressDialogLayout {
  rowWithCircularActivityIndicator,
  columnWithCircularActivityIndicator,
  columnReveredWithCircularActivityIndicator,
  justCircularActivityIndicator,
  overlayCircularActivityIndicator,
}