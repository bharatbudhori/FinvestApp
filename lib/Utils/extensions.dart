import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget padding({PaddingData? data}) {
    if (data == null) return this;
    data.left = data.left ?? 0;
    data.right = data.right ?? 0;
    data.top = data.top ?? 0;
    data.bottom = data.bottom ?? 0;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        data.left!.toDouble(),
        data.top!.toDouble(),
        data.right!.toDouble(),
        data.bottom!.toDouble(),
      ),
      child: this,
    );
  }
}

class PaddingData {
  int? left;
  int? right;
  int? top;
  int? bottom;

  PaddingData({
    required this.left,
    required this.right,
    required this.bottom,
    required this.top,
  });
}
