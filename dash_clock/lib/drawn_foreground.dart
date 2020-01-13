import 'package:flutter/material.dart';

import 'dash.dart';
import 'dash_metrics.dart';

/// A clock dash that is drawn with [CustomPainter]
///
class DrawnForeground extends Dash {
  /// Create a const clock [Dash].
  ///
  /// All of the parameters are required and must not be null.
  const DrawnForeground({
    @required int hour,
    @required int minute,
    @required Color color,
    @required this.thickness,
  })  : assert(hour != null),
        assert(minute != null),
        assert(color != null),
        assert(thickness != null),
        super(
          hour: hour,
          minute: minute,
          second: 0,
          color: color,
        );

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
    @required this.color,
    @required this.lineWidth,
  })  : assert(hour != null),
        assert(minute != null),
        assert(color != null),
        assert(lineWidth != null),
        assert(hour >= 0),
        assert(hour < 24),
        assert(minute >= 0),
        assert(minute < 60);

  int hour;
  int minute;
  Color color;
  double lineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint1 = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.square;

    final linePaint5 = Paint()
      ..color = color
      ..strokeWidth = lineWidth + 1
      ..strokeCap = StrokeCap.square;

    final linePaint15 = Paint()
      ..color = color
      ..strokeWidth = lineWidth + 2
      ..strokeCap = StrokeCap.square;

    final linePaint30 = Paint()
      ..color = color
      ..strokeWidth = lineWidth + 3
      ..strokeCap = StrokeCap.square;

    final dash = DashMetrics(size);
    int last = hour % 12;
    for (int h = 0; h <= last; h++) {
      for (int m = 0; m < 60; m++) {
        if (h == last && m > minute) {
          break;
        }
        var linePaint;
        if (m % 30 == 0) {
          linePaint = linePaint30;
        } else if (m % 15 == 0) {
          linePaint = linePaint15;
        } else if (m % 5 == 0) {
          linePaint = linePaint5;
        } else {
          linePaint = linePaint1;
        }
        if (h != last || m != 0) {
          canvas.drawLine(dash.dashP1(h, m), dash.dashP2(h, m), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) {
    return oldDelegate.hour != hour ||
        oldDelegate.minute != minute ||
        oldDelegate.color != color ||
        oldDelegate.lineWidth != lineWidth;
  }
}
