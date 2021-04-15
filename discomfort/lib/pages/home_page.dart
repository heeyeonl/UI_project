import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController timerController = new TextEditingController();
  int _counter = 1;
  Timer _timer;

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Lock the Phone',
          style: TextStyle(
            color: Colors.teal[50],
            letterSpacing: 2.5,
            fontFamily: 'SourceSansPro',
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (_counter > 0)
                  ? Text("")
                  : Text(
                      "DONE!",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        letterSpacing: 2.5,
                        fontFamily: 'SourceSansPro',
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.timer,
                      color: Colors.teal,
                    ),
                    hintText: "Please enter timer value in minutes",
                    hintStyle: TextStyle(
                      letterSpacing: 2.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSansPro',
                    ),
                  ),
                  controller: timerController,
                ),
              ),
              Text(
                '$_counter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  letterSpacing: 2.5,
                  fontFamily: 'SourceSansPro',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _counter = int.parse(timerController.text) * 60;
                  _startTimer();
                },
                child: Text(
                  'Lock the Phone, NOW!',
                  style: TextStyle(
                    letterSpacing: 2.5,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
