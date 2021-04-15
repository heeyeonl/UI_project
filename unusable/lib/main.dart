import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Change Brightness Setting';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  Random random = new Random();
  int num1 = 30;
  int num2 = 50;
  double _brightness = 0.0;
  bool isCorrect = true;
  bool isMax = false;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    double brightness = await Screen.brightness;
    setState(() {
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          isMax ? '$num1 - $num2' : '$num1 + $num2 = ',
          style: TextStyle(fontSize: 30.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter an answer',
            ),
          ),
        ),
        RaisedButton(
          child: Text('Done'),
          onPressed: () {
            String numStr = controller.text;
            int numInput = int.parse(numStr);

            int sumNum = num1 + num2;
            int subNum = num1 - num2;

            if (sumNum == numInput) {
              isCorrect = true;
              setState(() {
                double b = _brightness + (numInput * 0.001);
                if (b >= 1.0) {
                  _brightness = 1.0;
                  isMax = true;
                } else if (b < 0) {
                  _brightness = 0.0;
                } else {
                  _brightness = b;
                }
                num1 = random.nextInt(50);
                num2 = random.nextInt(50);
                Screen.setBrightness(_brightness);
              });
            } else if (subNum == numInput) {
              isCorrect = true;
              setState(() {
                double b = _brightness - (numInput.abs() * 0.001);
                if (b < 0.0) {
                  _brightness = 0.0;
                  isMax = false;
                } else if (b > 1.0) {
                  _brightness = 1.0;
                } else {
                  _brightness = b;
                }
                num1 = random.nextInt(50);
                num2 = random.nextInt(50);
                Screen.setBrightness(_brightness);
              });
            } else {
              isCorrect = false;
              showAlertDialog(context);
            }
          },
        ),
        Slider(
          value: _brightness,
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong input"),
      content: Text(isCorrect
          ? "Input must be between 0 and 100."
          : "Wrong answer! Try again."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
