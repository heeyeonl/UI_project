import 'package:flutter/material.dart';
import 'package:move_a_circle/main.dart';
// I used this as a reference:
// https://hackernoon.com/drawing-custom-shapes-and-lines-using-canvas-and-path-in-flutter-997dfb8fde5a

class SliderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = SliderValues.halfHeight;
    double radius = size.height / 4;
    double xPos = SliderValues.xPos;
    double colorVal = xPos * 0.005;
    var line = Paint();
    line.color = Colors.grey;
    line.style = PaintingStyle.fill;
    var circle = Paint();
    circle.color = Color.lerp(Colors.pink[300], Colors.yellow[300], colorVal);
    circle.style = PaintingStyle.fill;

    canvas.drawLine(Offset(0, height), Offset(size.width, height), line);
    canvas.drawCircle(Offset(xPos, height), radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
