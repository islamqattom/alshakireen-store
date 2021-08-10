import 'dart:convert';
import 'package:alshakireen/login/LoginRequest.dart';
import 'package:alshakireen/sharedScreen/BottomNavWidget.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginRepository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 135),
                Image.asset(
                  "assets/images/logo.png",
                  height: mUtils.height(context, 148),
                  width: mUtils.width(context, 151),
                ),
                SizedBox(height: 49),
                Container(
                  margin: const EdgeInsets.only(left: 83, right: 83),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(hintText: 'رقم الهاتف'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 83, right: 83),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(hintText: '*********', labelText: 'الرقم السري'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  child: Container(
                      margin: const EdgeInsets.only(left: 83, right: 83),
                      color: cUtils.primary,
                      height: mUtils.height(context, 39),
                      width: mUtils.width(context, 251),
                      child: Center(
                          child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'cairob'),
                      ))),
                  onTap: () {
                    loginRepository.login(new LoginRequest(phone.text.toString(), password.text.toString())).then((value) async {
                      if (value.success) {
                        final SharedPreferences prefs = await vUtils.prefs;
                        prefs.setString('user', jsonEncode(value.information));
                        VariablesUtils.user = value.information;
                        if (VariablesUtils.user.role == 1)
                          VariablesUtils.isAdmin = true;
                        else
                          VariablesUtils.isAdmin = false;
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavWidget()), (route) => false);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
