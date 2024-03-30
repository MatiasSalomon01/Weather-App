import 'package:flutter/material.dart';

class DotWithLine extends CustomPainter {
  final bool isFirst;
  final bool isLast;

  final int temp;
  final int minTemp;
  final int maxTemp;

  final int nextTemp;

  DotWithLine({
    super.repaint,
    required this.isFirst,
    required this.isLast,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.nextTemp,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintDot = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint paintLine = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final currentPercent =
        1 - (((temp - minTemp) / (maxTemp - minTemp)) * 100).toInt() / 100;
    final nextPercent =
        1 - (((nextTemp - minTemp) / (maxTemp - minTemp)) * 100).toInt() / 100;

    const double radius = 3.5;
    final Offset center = Offset(size.width / 2, size.height * currentPercent);

    if (!isFirst) {
      canvas.drawLine(Offset(0, size.height * currentPercent),
          Offset(size.width / 2, size.height * currentPercent), paintLine);
    }

    canvas.drawCircle(center, radius, paintDot);

    if (!isLast) {
      canvas.drawLine(Offset(size.width / 2, size.height * currentPercent),
          Offset(size.width, size.height * nextPercent), paintLine);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
