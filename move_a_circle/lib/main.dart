// painting and canvas code inspired by (and base code copied from)
// https://hackernoon.com/drawing-custom-shapes-and-lines-using-canvas-and-path-in-flutter-997dfb8fde5a
// and the example at
// https://api.flutter.dev/flutter/widgets/Listener-class.html

import 'package:flutter/material.dart';
import 'package:move_a_circle/slider_painter.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal[200],
        appBar: AppBar(
          title: Text('Move a circle'),
          backgroundColor: Colors.teal[200],
        ),
        body: CurvedSlider(),
      ),
    ),
  );
}

class CurvedSlider extends StatefulWidget {
  @override
  _CurvedSliderState createState() => _CurvedSliderState();
}

class SliderValues extends Object {
  // add all the state you want here.
  // you can refer to this state in the slider_painter
  static double halfHeight = 50;
  static double xPos;
}

class _CurvedSliderState extends State<CurvedSlider> {
  @override
  Widget build(BuildContext context) {
    final painter = SliderPainter();
    void _fingerDown(PointerEvent details) {
      // setState is a built-in function for forcing a redraw.
      // wrap the code that changes the state in a setState function
      // to force a redraw when the state changes.
      // the redraw actually calls your drawing method.
      setState(() {
        // your code here for finger down events.
        SliderValues.xPos = details.localPosition.dx;
        // print(SliderValues.xPos);
      });
    }

    return
        // a simple container.  It doesn't do anything.
        // you will add interaction to this widget.
        Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: Listener(
          onPointerDown: _fingerDown,
          // over ride the events you want to over ride.
          // see https://api.flutter.dev/flutter/widgets/Listener/Listener.html
          child: CustomPaint(
            // this is the custom painter for this widget.
            painter: painter,
          )),
    );
  }
}
