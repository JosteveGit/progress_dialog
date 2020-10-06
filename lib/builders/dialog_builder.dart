import 'package:flutter/material.dart';

class DialogBuilder {

  /// Returns a [title] positioned at the center if [centerTile] is true and [title] is not null.
  /// Returns a [Text] with data [title] if centerTile is false and [title] is not null.
  /// Returns null if [title] is null.
  static getTitle(title, bool centerTitle, titleStyle, layout) {
    if (layout.toString().contains("overlay") || layout.toString().contains("just") || title == null) {
      return null;
    }
    else if (centerTitle)
      return Center(
        child: Text(
          title ?? "",
          style: titleStyle,
        ),
      );
    return Text(
      title,
      style: titleStyle,
    );
  }

  /// Returns the elevation.
  /// if the layout is an "overlay" layout then it overrides to 0.0.
  static double getElevation(double elevation, layout) {
    if (layout.toString().contains("overlay")) {
      return 0.0;
    }
    return elevation;
  }

  /// Returns the color.
  /// if the layout is an "overlay" layout then it overrides to Colors.transparent
  static Color getBackgroundColor(Color color, layout) {
    if (layout.toString().contains("overlay")) {
      return Colors.transparent;
    }
    return color;
  }
}
