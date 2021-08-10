import 'package:alshakireen/SignUp/SignUpPage.dart';
import 'package:alshakireen/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: mUtils.height(context, 194),
                width: mUtils.width(context, 197),
              ),
              SizedBox(height: 35),
              InkWell(
                child: Container(
                  color: cUtils.primary,
                  height: mUtils.height(context, 41),
                  width: mUtils.width(context, 277),
                  child: Center(
                      child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'cairob'),
                  )),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
              ),
              SizedBox(height: 12),
              InkWell(
                  child: Container(
                      height: mUtils.height(context, 41),
                      width: mUtils.width(context, 277),
                      decoration: BoxDecoration(
                        border: Border.all(color: cUtils.primary),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Text(
                        "مستخدم جديد",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'cairob'),
                      ))),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()))),
            ],
          ),
        ),
      ),
    );
  }
}
