import 'package:flutter/material.dart';

/// Base clas for drawing dash.
///
abstract class Dash extends StatelessWidget {
  const Dash({
    @required this.hour,
    @required this.minute,
    @required this.second,
    @required this.color,
  })  : assert(hour != null),
        assert(minute != null),
        assert(second != null),
        assert(color != null);

  // Dash position.
  final int hour;
  final int minute;
  final int second;

  // Dash color.
  final Color color;
}
