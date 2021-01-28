import 'package:flutter/material.dart';

// the main curved slide class.

class CurvedSlider extends StatefulWidget {
  // more state, can be exposed.
  // where the state goes.
  final double value;
  // type signature for callbacks that report a value change.
  // see https://api.flutter.dev/flutter/foundation/ValueChanged.html
  final ValueChanged<double> onChanged;
  double radius;
  double xPos;
  Color color;

  // critical fail from class today (1/27/21)  placing parameters in the
  // { } brackets makes them optional.  Apparently even if you put @required
  // in front of them.
  // where the API is defined.
  CurvedSlider({
    // required named parameter  <-- fail.
    // spoiler alert:  inside {}s so not required.
    @required this.value,
    @required this.onChanged,
    this.radius,
    this.xPos,
  });

  @override
  _CurvedSliderState createState() => _CurvedSliderState();
}

// the state for the curved slider
class _CurvedSliderState extends State<CurvedSlider> {
  // any state I want in my slider.  such as x,y positions of the finger when
  // the finger is down.
  double fingerX = 0.0;
  double thumbPos = 0.0;
  Color color = Colors.white;

  // and helper functions go here too.
  void _updateXpos(PointerEvent details) {
    fingerX = details.position.dx;
  }

  // where interaction is defined for real.  This is where the callback finally
  // gets called.
  void _fingerDown(PointerEvent details) {
    // this is where I call the callback.  the "widget" object refers to
    // CurvedSlider as declared starting on line 7 above.
    print('_fingerDown');
    _updateXpos(details);
    widget.onChanged(fingerX);
    color = Colors.yellow;
  }

  void _fingerMove(PointerEvent details) {
    _updateXpos(details);
    widget.onChanged(fingerX);
  }

  void _fingerUp(PointerEvent details) {
    print('_fingerUp');
    setState(() {
      widget.color = Colors.white;
    });
  }

  // the heart of the curved slider.
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        child: Listener(
          // where the interaction starts.
          // probably want to handle other pointer events.
          onPointerDown: _fingerDown,
          onPointerMove: _fingerMove,
          onPointerUp: _fingerUp,
          child: CustomPaint(
              // call painter constructor with parameters.
              // such as state for the paint algorithms.
              painter: SliderPainter(fingerX, widget.radius, color)),
        ));
  }
}

// handles the redraws for the slider.
// this where the rendering is defined
class SliderPainter extends CustomPainter {
  double xPos;
  double radius;
  Color color;

  SliderPainter(this.xPos, this.radius, this.color);

  @override
  // this is really where the rending is defined.
  void paint(Canvas canvas, Size size) {
    // double height = CurvedSlider.halfHeight;
    double height = 50.0;
    double colorVal = xPos * 0.005;
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
