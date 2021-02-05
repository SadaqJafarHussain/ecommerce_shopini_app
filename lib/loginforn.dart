import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginAndRegistrationForm extends StatefulWidget {
  final Color mainColor;
  final Color subColor;
  final String mainText;
  final String subText;
  final Function changScreen;
  final GlobalKey<ScaffoldState> scafoldKey;
  LoginAndRegistrationForm({
    this.mainColor,
    this.scafoldKey,
    this.mainText,
    this.changScreen,
    this.subColor,
    this.subText,
  });

  @override
  _LoginAndRegistrationFormState createState() =>
      _LoginAndRegistrationFormState();
}

class _LoginAndRegistrationFormState extends State<LoginAndRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();
  bool _obscureText = true;
  String _userName;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 10,
      height: MediaQuery.of(context).size.height * 10,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.changScreen,
            child: Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 280, bottom: 240, top: 0),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, left: 10),
                      child: Text(
                        widget.subText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xff052555),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  ),
                ),
                width: 380,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(193)),
                  color: widget.subColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 280,
                      ),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12, right: 10),
                          child: Text(
                            widget.mainText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: Color(0xff052555),
                        ),
                      ),
                    ),
                    widget.mainText == 'Sign up'
                        ? Padding(
                            padding: EdgeInsets.only(right: 55, top: 20),
                            child: TextFormField(
                              onSaved: (val) => _userName = val,
                              controller: userController,
                              validator: (value) => value.length < 6
                                  ? 'username too short'
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'username',
                                hintText: 'at least 6 character',
                                fillColor: Colors.white,
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                                prefixIcon: Icon(
                                  Icons.face,
                                  color: Color(0xff052555),
                                  size: 30,
                                ),
                                enabled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.deepOrange,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          )
                        : Text(''),
                    Padding(
                      padding: EdgeInsets.only(right: 55, top: 5),
                      child: TextFormField(
                        onSaved: (val) => _email = val,
                        controller: emailController,
                        validator: (value) =>
                            !value.contains('@') ? 'email is not valid' : null,
                        decoration: InputDecoration(
                          labelText: 'email',
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          hintText: 'Enter your email',
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff052555),
                            size: 30,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 55,
                      ),
                      child: TextFormField(
                        onSaved: (val) => _password = val,
                        controller: passwordController,
                        validator: (value) =>
                            value.length < 6 ? 'password weak' : null,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                            child: _obscureText
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 30,
                                    color: Color(0xff052555),
                                  )
                                : Icon(
                                    Icons.visibility,
                                    size: 30,
                                    color: Color(0xff052555),
                                  ),
                          ),
                          hintText: 'must be at least 6 charactar',
                          labelText: 'password',
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff052555),
                            size: 30,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              width: 380,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(200)),
                color: widget.mainColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 340, left: 120),
            child: _isSubmitting == true
                ? Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(0xff052555)),
                    ))
                : SizedBox(
                    width: 150,
                    height: 60,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Color(0xff052555),
                      onPressed: submit,
                      elevation: 10,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  submit() {
    if (_formKey.currentState.validate()) {
      if (widget.mainText == 'Sign up') {
        _formKey.currentState.save();
        signUp();
      } else if (widget.mainText == 'Log in') {
        _formKey.currentState.save();
        logIn();
      }
    }
  }

  signUp() async {
    setState(() {
      _isSubmitting = true;
    });
    http.Response response = await http.post(
        'http://10.0.2.2:5000/auth/local/register',
        body: ({
          "username": _userName,
          "email": _email,
          "password": _password
        }));
    final decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(decodedData);
      setState(() {
        _isSubmitting = false;
      });
      _storedData(decodedData);
      showSnack();
      redirectUser();
    } else {
      setState(() {
        _isSubmitting = false;
      });
      final String errorMessage =
          decodedData['message'][0]['messages'][0]['message'].toString();

      showErrorMessage(errorMessage);
    }
  }

  void _storedData(responseData) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('jwt', () => responseData['jwt']);
    pref.setString('user', json.encode(user));
  }

  showErrorMessage(String errorMSg) {
    final snackbar = SnackBar(
        content: Text(
      errorMSg,
      style: TextStyle(
        color: Colors.red,
      ),
    ));
    widget.scafoldKey.currentState.showSnackBar(snackbar);
    throw Exception('Error registering : $errorMSg');
  }

  logIn() async {
    setState(() {
      _isSubmitting = true;
    });
    http.Response response = await http.post('http://10.0.2.2:5000/auth/local',
        body: ({"identifier": _email, "password": _password}));
    final decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(decodedData);
      setState(() {
        _isSubmitting = false;
      });
      _storedData(decodedData);
      showSnack();
      redirectUser();
    } else {
      setState(() {
        _isSubmitting = false;
      });
      print(decodedData);
      final String errorMessage =
          decodedData['message'][0]['messages'][0]['message'].toString();
      showErrorMessage(errorMessage);
    }
  }

  redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void showSnack() {
    final snackbar = SnackBar(
        content: widget.mainText == 'Sign up'
            ? Text(
                'User $_userName successfully created !',
                style: TextStyle(
                  color: Colors.green,
                ),
              )
            : Text(
                'User successfully Logged in !',
                style: TextStyle(
                  color: Colors.green,
                ),
              ));
    widget.scafoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }
}
