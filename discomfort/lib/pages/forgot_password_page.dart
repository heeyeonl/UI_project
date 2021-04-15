import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  static String id = 'forgot-password';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFF9D77),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get a link to reset your password',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Color(0xFFF46F6F),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    // TODO: Send Password Reset Link
                    /*FIXME: This is broken */
                    _showToast(
                        context, 'Email Sent to ${_emailController.text}!');
                  },
                  child: Text(
                    'Send Link',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String txt) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
          content: Text(txt),
          action: SnackBarAction(
            label: 'X',
            onPressed: _scaffoldKey.currentState.hideCurrentSnackBar,
          )),
    );
  }
}
