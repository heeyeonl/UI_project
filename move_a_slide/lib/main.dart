import 'package:flutter/material.dart';
import 'package:move_a_slide/CurvedSlider.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            title: Text('Curved Slider'),
            backgroundColor: Colors.teal,
          ),
          body: SliderTests()),
    ),
  );
}

class SliderTests extends StatefulWidget {
  @override
  _SliderTestsState createState() => _SliderTestsState();
}

class _SliderTestsState extends State<SliderTests> {
  double mySliderValue = 2.0;

  @override
  Widget build(BuildContext context) {
    return
        // so my widget is a column.  (that's just a layout widget)
        Column(
      children: <Widget>[
        // and my curved slider.
        CurvedSlider(
          // this is the constructor call to my curved slider.
          // I included an onChanged callback.
          // this callback is called when the value of the slider
          // changes.
          onChanged: (double newValue) {
            // by calling setState, I force a redraw.
            setState(() {
              // where state changes happen.
              mySliderValue = newValue;
            });
          },
          // other parameters, these are optional though.
          radius: 20,
        ),
        // and finally a text box.
        Text('Slider value: ${mySliderValue.round()}'),
      ],
    );
  }
}
