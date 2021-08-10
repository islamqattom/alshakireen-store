import 'dart:async';
import 'dart:convert';
import 'package:alshakireen/intro/IntroPage.dart';
import 'package:alshakireen/login/LoginResponse.dart';
import 'package:alshakireen/sharedScreen/BottomNavWidget.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('user') != '' && _prefs.getString('user') != null) {
      var userJson = jsonDecode(_prefs.getString('user'));
      VariablesUtils.user = Information.fromJson(userJson);
      if (VariablesUtils.user.role == 1)
        VariablesUtils.isAdmin = true;
      else
        VariablesUtils.isAdmin = false;

      timer(BottomNavWidget());
    } else {
      timer(IntroPage());
    }
  }

  void timer(Widget widget) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cUtils.primary,
      child: Center(
        child: Image.asset(
          "assets/images/logo_white.png",
          width: mUtils.width(context, 197),
          height: mUtils.height(context, 194),
        ),
      ),
    );
  }
}
