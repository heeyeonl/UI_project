import 'package:flutter/material.dart';
import 'package:generalized_slider/CurvedSlider.dart';

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
  String valueText;
  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CurvedSlider(
          onChanged: (String newValue) {
            // list
            setState(() {
              valueText = newValue; // build a string for loop, update valueText
            });
          },
          radius: 20,
          numCircles: 5,
        ),
        Text(
          '$valueText',
          style: TextStyle(color: textColor),
        ),
        // and finally a text box.
      ],
    );
  }
}
