import 'package:flutter/material.dart';

class CurvedSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  double radius;
  double xPos;
  Color circleColor;

  CurvedSlider({
    @required this.value,
    @required this.onChanged,
    @required this.circleColor,
    this.radius,
    this.xPos,
  });

  @override
  _CurvedSliderState createState() => _CurvedSliderState();
}

class _CurvedSliderState extends State<CurvedSlider> {
  double fingerX = 0.0;
  double thumbPos = 0.0;
  Color circleColor = Colors.white;

  void _updateXpos(PointerEvent details) {
    fingerX = details.position.dx;
  }

  void _fingerDown(PointerEvent details) {
    print('_fingerDown');
    _updateXpos(details);
    widget.onChanged(fingerX);
    circleColor = Colors.yellow;
  }

  void _fingerMove(PointerEvent details) {
    _updateXpos(details);
    widget.onChanged(fingerX);
  }

  void _fingerUp(PointerEvent details) {
    print('_fingerUp');
    _updateXpos(details);
    widget.onChanged(fingerX);
    circleColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        child: Listener(
          onPointerDown: _fingerDown,
          onPointerMove: _fingerMove,
          onPointerUp: _fingerUp,
          child: CustomPaint(
              painter: SliderPainter(fingerX, widget.radius, circleColor)),
        ));
  }
}

class SliderPainter extends CustomPainter {
  double xPos;
  double radius;
  Color color;

  SliderPainter(this.xPos, this.radius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double height = 50.0;
    var line = Paint();
    line.color = Colors.white;
    line.style = PaintingStyle.fill;
    var circle = Paint();
    circle.color = color;
    circle.style = PaintingStyle.fill;

    canvas.drawLine(Offset(0, height), Offset(size.width, height), line);
    canvas.drawCircle(Offset(xPos, height), radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
