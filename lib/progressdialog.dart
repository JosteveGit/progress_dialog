import 'package:flutter/material.dart';

///A Customizable Progress Dialog.
///
/// Examples
///
/// 1.Simple use.
///class Home extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) {
///    return Center(
///      child: RaisedButton(
///        onPressed: (){
///          ProgressDialog(context: context).show(message: "Loading...");
///        },
///      ),
///    );
///  }
///}
///
/// 2.With Title and styles.
/// class Home extends StatelessWidget {
//  @override
///  Widget build(BuildContext context) {
///    return Center(
///      child: RaisedButton(
///        onPressed: () {
///          ProgressDialog(context: context).show(
///            message: "Please wait...",
///            title: "Fetching Data",
///            centerTile: true,
///            titleStyle: TextStyle(fontSize: 40, color: Colors.orange[900]),
///            messageStyle: TextStyle(fontSize: 20, color: Colors.green)
///          );
///        },
///      ),
///    );
///  }
///}
///
/// 3. Dismissing the dialog after 10 seconds.
/// class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: RaisedButton(
//        onPressed: () {
//          ProgressDialog dialog = ProgressDialog(context: context)..show(
//            message: "Please wait...",
//            title: "Fetching Data",
//            centerTile: true,
//            titleStyle: TextStyle(fontSize: 40, color: Colors.orange[900]),
//            messageStyle: TextStyle(fontSize: 20, color: Colors.green)
//          );
//          Timer(Duration(seconds: 10), (){dialog.dismiss();});
//        },
//      ),
//    );
//  }
//}

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

  ///The elevation in [Dialog].
  final double elevation;

  ///The dialog context making dismissing the dialog from the dismiss method possible.
  BuildContext _dialogContext;

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

  ///Method to show the dialog with parameters; [title], [message], [layout], [centerTile], [titleStyle], [messageStyle], [contentPadding], [backGroundColor].
  ///If [title] is null, the space for [title] text will also be gone.
  ///[message] cannot be null.
  ///[layout] defines what type of progress indicator is shown and how it is displayed.
  ///if [centerTile] is true, then [title] will be positioned at the center on the horizontal axis.
  ///[titleStyle] styles the title.
  ///[messageStyle] styles the message.
  ///[contentPadding] is from [SimpleDialog] to add some space between the content and the dialog.
  ///[backGroundColor] : to change the background color of the dialog.
  void show({
    String title,
    @required String message,
    ProgressDialogLayout layout = ProgressDialogLayout.rowWithCircularProgressIndicator,
    bool centerTile = false,
    TextStyle titleStyle,
    TextStyle messageStyle,
    EdgeInsets contentPadding,
    Color backGroundColor = Colors.white,
  }) {
    assert(context != null);
    assert(useRootNavigator != null);
    assert(message != null);
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (context) {
        _dialogContext = context;
        _canPop = true;
        return SimpleDialog(
          backgroundColor: backGroundColor,
          title: _getTitle(title, centerTile, titleStyle),
          shape: _getShape(shape),
          elevation: elevation,
          contentPadding: _getPadding(contentPadding),
          children: <Widget>[_getBody(layout, message, messageStyle)],
        );
      },
    );
  }

  /// Returns the [contentPadding] passed if it is not null else it  returns a fixed padding EdgeInsets.symmetric(vertical: 23, horizontal: 25).
  _getPadding(contentPadding) => contentPadding == null
      ? const EdgeInsets.symmetric(vertical: 23, horizontal: 25)
      : contentPadding;

  /// Returns the [shape] passed if it is not null else it returns a fixed shape RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)).
  _getShape(shape) => shape == null
      ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
      : shape;

  /// Returns a [title] positioned at the center if [centerTile] is true and [title] is not null.
  /// Returns a [Text] with data [title] if centerTile is false and [title] is not null.
  /// Returns null if [title] is null.
  _getTitle(title, bool centerTile, titleStyle) {
    if (title == null)
      return null;
    else if (centerTile)
      return Center(
          child: Text(
        title,
        style: titleStyle,
      ));
    return Text(
      title,
      style: titleStyle,
    );
  }

  ///Returns a dialog depending on the [layout] specified.
  /// If the [layout] is [ProgressDialogLayout.columnWithCircularProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] below the [message] [Text].
  /// If the [layout] is [ProgressDialogLayout.columnReversedWithLinearProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] above the [message] [Text].
  /// If the [layout] is [ProgressDialogLayout.rowWithCircularProgressIndicator], it returns a [ProgressDialog] with a [CircularProgressIndicator] by the left of the [message] [Text].
  /// If the [layout] is [ProgressDialogLayout.columnWithLinearProgressIndicator], it returns a [ProgressDialog] with a [LinearProgressIndicator] below the [message] [Text].
  /// If the [layout] is [ProgressDialogLayout.columnWithLinearProgressIndicator], it returns a [ProgressDialog] with a [LinearProgressIndicator] above the [message] [Text].
  _getBody(ProgressDialogLayout layout, String messageString,
      TextStyle messageStyle) {
    Widget message = _message(messageString, messageStyle);
    switch (layout) {
      case ProgressDialogLayout.columnWithCircularProgressIndicator:
        return _buildColumnCircularProgressDialog(message);
        break;
      case ProgressDialogLayout.columnReveredWithCircularProgressIndicator:
        return _buildColumnCircularProgressDialog(message, true);
        break;
      case ProgressDialogLayout.rowWithCircularProgressIndicator:
        return _buildRowCircularProgressDialog(message);
        break;
      case ProgressDialogLayout.columnWithLinearProgressIndicator:
        return _buildLinearProgressDialog(message);
        break;
      case ProgressDialogLayout.columnReversedWithLinearProgressIndicator:
        return _buildLinearProgressDialog(message, true);
        break;
    }
  }

  /// The [message] wrapped in a [Text] and the [Text] wrapped in [Expanded].
  Widget _message(String message, messageStyle) => Expanded(
        child: Text(
          message,
          textAlign: TextAlign.left,
          overflow: TextOverflow.clip,
          style: messageStyle,
        ),
      );

  Widget _buildRowCircularProgressDialog(Widget message) {
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

  Widget _buildColumnCircularProgressDialog(Widget message,
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

  Widget _buildLinearProgressDialog(Widget message, [reversed = false]) {
    var body = [
      message,
      SizedBox(
        height: 15,
      ),
      LinearProgressIndicator(),
    ];
    return Column(children: reversed ? body.reversed.toList() : body);
  }

  //Dismisses the dialog if it is shown.
  void dismiss() {
    if (_canPop) {
      _canPop = false;
      Navigator.pop(_dialogContext);
      return;
    }
    throw new Exception(
        "You cannot dismiss a ProgressDialog that has not been shown.");
  }
}

/// The progress dialog layouts.
enum ProgressDialogLayout {
  columnWithCircularProgressIndicator,
  columnReveredWithCircularProgressIndicator,
  rowWithCircularProgressIndicator,
  columnWithLinearProgressIndicator,
  columnReversedWithLinearProgressIndicator
}
