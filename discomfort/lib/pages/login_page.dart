import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String _username;
  String _password;
  BuildContext myContext;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Lock the Phone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: 'Pacifico',
                  ),
                ),
                Container(
                  width: 300,
                  height: 200,
                  child: Image.asset('images/arabica-29.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 15, bottom: 10),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        fontFamily: 'Raleway-Light',
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 15, bottom: 10),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Raleway-Light',
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color(0xFFE5A024),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      _pushRoute(HomePage());
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.teal[50],
                        fontFamily: 'Raleway-Light',
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _pushRoute(ForgotPasswordPage());
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.teal[50],
                      fontSize: 15,
                    ),
                  ),
                ),
                /* SPACE FILLER */
                SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'New User? Create an Account',
                    style: TextStyle(color: Color(0xFFE5A024), fontSize: 15),
                    // style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _pushRoute(Widget page) async {
    return await Navigator.of(myContext)
        .push(MaterialPageRoute<void>(builder: (context) {
      return page;
    }));
  }
}
