import 'package:flutter/material.dart';

class GotaDeAguaPainter extends CustomPainter {
  final double porcentajeLluvia;

  GotaDeAguaPainter({this.porcentajeLluvia = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = .8
      ..style = PaintingStyle.stroke;

    final path = Path();

    final double width = size.width;
    final double height = size.height;

    path.moveTo(width * 0.5, 0);
    path.quadraticBezierTo(
        width * 0.2, height * 0.3, width * 0.35, height * 0.6);
    path.quadraticBezierTo(
        width * 0.5, height * 0.8, width * 0.65, height * 0.6);
    path.quadraticBezierTo(width * 0.8, height * 0.3, width * 0.5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
