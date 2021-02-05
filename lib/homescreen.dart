import 'package:flutter/material.dart';
import 'package:bazzar/loginforn.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();

  bool isItRegister = true;

  changeCheckerBool() {
    if (isItRegister == true) {
      setState(() {
        isItRegister = false;
      });
    } else if (isItRegister == false) {
      setState(() {
        isItRegister = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      backgroundColor: Color(0xff052555),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                  size: 30,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150),
                            bottomRight: Radius.circular(150))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Shopini',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lobster',
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                  size: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: isItRegister
                ? LoginAndRegistrationForm(
                    mainText: 'Sign up',
                    subText: 'Log in',
                    subColor: Colors.cyan,
                    mainColor: Colors.white,
                    changScreen: changeCheckerBool,
                    scafoldKey: scafoldKey,
                  )
                : LoginAndRegistrationForm(
                    mainText: 'Log in',
                    subText: 'Sign up',
                    mainColor: Colors.white,
                    subColor: Colors.cyan,
                    changScreen: changeCheckerBool,
                    scafoldKey: scafoldKey,
                  ),
          )
        ],
      ),
    );
  }
}
