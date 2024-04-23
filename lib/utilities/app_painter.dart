import 'package:familylost_faan/utilities/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTWH(0, 0, width, height));
    paint.color = AppColors.mainColor;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start from the top left corner
    ovalPath.moveTo(0.2, height * 0.2);
    // Draw an arc from the top left corner to the top right corner
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);
    // Draw an arc from the top right corner to the bottom right corner
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);
    paint.color = AppColors.secondaryColor;

    ovalPath.lineTo(0, height);

    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
