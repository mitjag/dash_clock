import 'package:flutter/material.dart';

import 'dash_metrics.dart';

/// A clock dash that is drawn with [CustomPainter]
///
class DrawnBackground extends StatelessWidget {
  /// Create a const clock [DrawnBackground].
  ///
  /// All of the parameters are required and must not be null.
  const DrawnBackground({
    @required this.color,
    @required this.thickness,
  })  : assert(color != null),
        assert(thickness != null);

  final Color color;

  /// How thick the hand should be drawn, in logical pixels.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _BackgroundPainter(
            color: color,
            lineWidth: thickness,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock dash.
class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    @required this.color,
    @required this.lineWidth,
  })  : assert(color != null),
        assert(lineWidth != null);

  Color color;
  double lineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint5 = Paint()
      ..color = color.withAlpha(128)
      ..strokeWidth = lineWidth + 1
      ..strokeCap = StrokeCap.square;

    final linePaint15 = Paint()
      ..color = color.withAlpha(192)
      ..strokeWidth = lineWidth + 2
      ..strokeCap = StrokeCap.square;

    final linePaint30 = Paint()
      ..color = color
      ..strokeWidth = lineWidth + 3
      ..strokeCap = StrokeCap.square;

    var dash = DashMetrics(size);

    for (int h = 0; h < 12; h++) {
      for (int m = 0; m < 60; m = m + 5) {
        var linePaint;
        if (m % 30 == 0) {
          linePaint = linePaint30;
        } else if (m % 15 == 0) {
          linePaint = linePaint15;
        } else {
          linePaint = linePaint5;
        }
        canvas.drawLine(dash.backgroundP1(h, m), dash.backgroundP2(h, m), linePaint);
      }
    }

    final rectPaint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawRect(dash.rect(0), rectPaint);
    canvas.drawRect(dash.rect(3), rectPaint);
    canvas.drawRect(dash.rect(6), rectPaint);
    canvas.drawRect(dash.rect(9), rectPaint);
  }

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.lineWidth != lineWidth;
  }
}
