import 'package:flutter/material.dart';

/// Calculations for dash position on the screen/canvas
///
class DashMetrics {
  Size size;

  double width;
  double step;
  double offsetX;
  double offsetY;

  /// Used for grouping hours into 4 groups 3, 6, 9, 12
  static const Map<int, int> offsetXPerHour = const {
    0: 0,
    1: 0,
    2: 0,
    3: 1,
    4: 1,
    5: 1,
    6: 2,
    7: 2,
    8: 2,
    9: 3,
    10: 3,
    11: 3
  };

  DashMetrics(this.size) {
    this.size = size;
    _calculate();
  }

  void _calculate() {
    width = (size.longestSide * 0.9) / 12; // hours
    step = (size.shortestSide * 0.9) / 60; // minutes
    offsetX = size.longestSide * 0.01; // 1% of width
    offsetY = size.shortestSide * 0.01; // 1% of height
  }

  int _mod12(int hour) {
    return hour % 12;
  }

  double _hourOffsetX(int hour) {
    return 2 * offsetX + width * hour + 2 * offsetX * offsetXPerHour[hour];
  }

  double _minuteOffsetY(int minute) {
    return size.shortestSide - 5 * offsetY - step * minute;
  }

  Offset dashP1(int hour, int minute) {
    return _dash(_mod12(hour), minute, 0.1);
  }

  Offset dashP2(int hour, minute) {
    return _dash(_mod12(hour), minute, 0.9);
  }

  Offset _dash(int hour, int minute, double scale) {
    return Offset(_hourOffsetX(hour) + width * scale, _minuteOffsetY(minute));
  }

  Rect rect(int hour) {
    var a = Offset(_hourOffsetX(_mod12(hour)), _minuteOffsetY(-1));
    var b = Offset(_hourOffsetX(_mod12(hour)) + 3 * width, _minuteOffsetY(60));

    return Rect.fromPoints(a, b);
  }
}
