import 'package:flutter/material.dart';

class CurvedSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  double radius;
  double xPos;
  int numCircles;

  CurvedSlider({
    @required this.value,
    @required this.onChanged,
    this.radius,
    this.xPos,
    this.numCircles,
  });

  @override
  _CurvedSliderState createState() => _CurvedSliderState();
}

class _CurvedSliderState extends State<CurvedSlider> {
  List<double> sliderValues = new List<double>();
  List<bool> sliderActives = new List<bool>();
  double thumbPos;
  bool isFirst = false;
  int index;

  void _updateXpos(int i, PointerEvent details) {
    sliderValues[i] = details.position.dx;
  }

  void _fingerDown(PointerEvent details) {
    print('_fingerDown');
    isFirst = true;
    thumbPos = details.position.dx;
    print('thumbPos: $thumbPos');
    print('sliderValues: $sliderValues');
    for (int i = 0; i < widget.numCircles; i++) {
      if (sliderValues[i] < thumbPos + widget.radius &&
          sliderValues[i] > thumbPos - widget.radius) {
        sliderActives[i] = true;
        index = i;
      }
    }
    _updateXpos(index, details);
    widget.onChanged(sliderValues[index]);
  }

  void _fingerMove(PointerEvent details) {
    _updateXpos(index, details);
    widget.onChanged(sliderValues[index]);
  }

  void _fingerUp(PointerEvent details) {
    print('_fingerUp');
    _updateXpos(index, details);
    widget.onChanged(sliderValues[index]);
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
                  widget.numCircles, isFirst)),
        ));
  }
}

class SliderPainter extends CustomPainter {
  List<double> sliderValues = new List<double>();
  List<bool> sliderActives = new List<bool>();
  double radius;
  int numCircles;
  bool isFirst;

  SliderPainter(this.sliderValues, this.sliderActives, this.radius,
      this.numCircles, this.isFirst);

  @override
  void paint(Canvas canvas, Size size) {
    double height = 50.0;
    var line = Paint();
    line.color = Colors.white;
    line.style = PaintingStyle.fill;
    canvas.drawLine(Offset(0, height), Offset(size.width, height), line);

    for (int i = 0; i < numCircles; i++) {
      if (!isFirst) {
        print('isFirst? $isFirst');
        sliderValues.add(i * 100.0);
        sliderActives.add(false);
      }
      var circle = Paint();
      circle.color = Color.lerp(Colors.pink, Colors.yellow, i * 0.4);
      circle.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(sliderValues[i], height), radius, circle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
