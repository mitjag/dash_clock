import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'dash.dart';
import 'dash_metrics.dart';

/// A clock dash that is drawn with [CustomPainter]
///
class DrawnDash extends Dash {
  /// Create a const clock [Dash].
  ///
  /// All of the parameters are required and must not be null.
  const DrawnDash({
    @required int hour,
    @required int minute,
    @required int second,
    @required Color color,
    @required this.thickness,
  })  : assert(hour != null),
        assert(minute != null),
        assert(second != null),
        assert(color != null),
        assert(thickness != null),
        super(hour: hour, minute: minute, second: second, color: color);

  /// How thick the hand should be drawn, in logical pixels.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _DashPainter(
            hour: hour,
            minute: minute,
            second: second,
            color: color,
            lineWidth: thickness,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock dash.
class _DashPainter extends CustomPainter {
  _DashPainter({
    @required this.hour,
    @required this.minute,
    @required this.second,
    @required this.color,
    @required this.lineWidth,
  })  : assert(hour != null),
        assert(minute != null),
        assert(second != null),
        assert(color != null),
        assert(lineWidth != null),
        assert(hour >= 0),
        assert(hour < 24),
        assert(minute >= 0),
        assert(minute < 60),
        assert(second >= 0),
        assert(second < 60);

  Color color;
  int hour;
  int minute;
  int second;
  double lineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.square;

    final dash = DashMetrics(size);
    canvas.drawLine(
        dash.dashP1(hour, second), dash.dashP2(hour, second), linePaint);
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) {
    return oldDelegate.hour != hour ||
        oldDelegate.minute != minute ||
        oldDelegate.second != second ||
        oldDelegate.color != color ||
        oldDelegate.lineWidth != lineWidth;
  }
}
