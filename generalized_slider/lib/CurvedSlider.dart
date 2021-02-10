import 'package:flutter/material.dart';

class CurvedSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  double radius;
  double xPos;
  Color circleColor;
  Color textColor;
  int numCircles;

  CurvedSlider({
    @required this.value,
    @required this.onChanged,
    @required this.circleColor,
    this.radius,
    this.xPos,
    this.textColor,
    this.numCircles,
  });

  @override
  _CurvedSliderState createState() => _CurvedSliderState();
}

class _CurvedSliderState extends State<CurvedSlider> {
  List<double> sliderValues = new List<double>();
  List<bool> sliderActives = new List<bool>();
  double thumbPos = 0.0;
  Color circleColor = Colors.white;
  Color textColor = Colors.red;

  void _updateXpos(PointerEvent details) {
    sliderValues[0] = details.position.dx;
  }

  void _fingerDown(PointerEvent details) {
    print('_fingerDown');
    _updateXpos(details);
    circleColor = Colors.yellow;
    textColor = Colors.yellow;
    widget.textColor = textColor;
    widget.onChanged(sliderValues.elementAt(0));
  }

  void _fingerMove(PointerEvent details) {
    _updateXpos(details);
    textColor = Colors.yellow;
    widget.textColor = textColor;
    widget.onChanged(sliderValues[0]);
  }

  void _fingerUp(PointerEvent details) {
    print('_fingerUp');
    _updateXpos(details);
    circleColor = Colors.white;
    textColor = Colors.white;
    widget.textColor = textColor;
    widget.onChanged(sliderValues[0]);
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
              painter: SliderPainter(sliderValues, sliderActives, widget.radius,
                  circleColor, widget.numCircles)),
        ));
  }
}

class SliderPainter extends CustomPainter {
  List<double> sliderValues = new List<double>();
  List<bool> sliderActives = new List<bool>();
  double radius;
  Color color;
  int numCircles;

  SliderPainter(this.sliderValues, this.sliderActives, this.radius, this.color,
      this.numCircles);

  @override
  void paint(Canvas canvas, Size size) {
    double height = 50.0;
    var line = Paint();
    line.color = Colors.white;
    line.style = PaintingStyle.fill;

    canvas.drawLine(Offset(0, height), Offset(size.width, height), line);
    for (int i = 0; i < numCircles; i++) {
      var circle = Paint();
      circle.color = color;
      circle.style = PaintingStyle.fill;
      sliderValues.add(i * 50.0);
      sliderActives.add(false);
      canvas.drawCircle(
          Offset(sliderValues.elementAt(i), height), radius, circle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
