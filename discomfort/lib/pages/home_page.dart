import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _latestHardwareButtonEvent;
  BuildContext myContext;

  StreamSubscription<HardwareButtons.VolumeButtonEvent>
      _volumeButtonSubscription;
  StreamSubscription<HardwareButtons.HomeButtonEvent> _homeButtonSubscription;
  StreamSubscription<HardwareButtons.LockButtonEvent> _lockButtonSubscription;
  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'What made you want to lock your phone?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 2.5,
              fontFamily: 'SourceSansPro',
            ),
          ),
          content: TextField(
            controller: _textFieldController,
            textInputAction: TextInputAction.go,
            // keyboardType: TextInputType.(),

            decoration: InputDecoration(hintText: "Enter your answer"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              },
            )
          ],
        );
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _volumeButtonSubscription =
  //       HardwareButtons.volumeButtonEvents.listen((event) {
  //     setState(() {
  //       _latestHardwareButtonEvent = event.toString();
  //     });
  //   });
  //
  //   _homeButtonSubscription = HardwareButtons.homeButtonEvents.listen((event) {
  //     setState(() {
  //       _latestHardwareButtonEvent = 'HOME_BUTTON';
  //     });
  //   });
  //
  //   _lockButtonSubscription = HardwareButtons.lockButtonEvents.listen((event) {
  //     setState(() {
  //       _latestHardwareButtonEvent = 'LOCK_BUTTON';
  //     });
  //   });
  // }

  final TextEditingController timerController = new TextEditingController();
  int _counter = 0;
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
    _volumeButtonSubscription?.cancel();
    _homeButtonSubscription?.cancel();
    _lockButtonSubscription?.cancel();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: (_counter > 0) ? Colors.blueGrey[700] : Colors.teal,
          title: Text(
            'Lock the Phone',
            style: TextStyle(
              color: Colors.teal[50],
              letterSpacing: 2.5,
              fontFamily: 'SourceSansPro',
            ),
          ),
        ),
        backgroundColor: (_counter > 0) ? Colors.blueGrey[700] : Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text('Value: $_latestHardwareButtonEvent\n'),
                (_counter > 0)
                    ? Text(
                        "Seconds left...",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 2.5,
                          fontFamily: 'SourceSansPro',
                        ),
                      )
                    : Text(
                        "DONE!",
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          letterSpacing: 2.5,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                Text(
                  '$_counter',
                  style: TextStyle(
                    color: (_counter > 0) ? Color(0xFFE5A024) : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                    letterSpacing: 2.5,
                    fontFamily: 'SourceSansPro',
                  ),
                ),
                (_counter == 0)
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 50.0,
                          right: 50.0,
                          top: 30,
                          bottom: 30,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.teal,
                            ),
                            hintText: "Enter timer value in minutes",
                            hintStyle: TextStyle(
                              letterSpacing: 0.5,
                              fontSize: 20.0,
                              fontFamily: 'SourceSansPro',
                            ),
                          ),
                          controller: timerController,
                        ),
                      )
                    : SizedBox(
                        height: 30,
                      ),
                (_counter > 0)
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () => _displayDialog(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Phone Locked! Click to unlock.',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway-Light',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFE5A024),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            _counter = int.parse(timerController.text) * 60;
                            _startTimer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Lock the Phone, NOW!',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway-Light',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
