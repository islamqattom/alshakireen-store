import 'package:alshakireen/SignUp/SignUpRepository.dart';
import 'package:alshakireen/SignUp/SignUpRequest.dart';
import 'package:alshakireen/login/LoginPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
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
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(hintText: 'الإسم'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'name is required';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phone,
                        decoration: InputDecoration(hintText: 'رقم الهاتف'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'phone is required';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(hintText: 'الايميل'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email is required';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(hintText: 'الرقم السري'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          height: mUtils.height(context, 40),
                          color: cUtils.primary,
                          child: Center(
                              child: Text(
                            "تسجيل",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'cairor'),
                          )),
                        ),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            if (checkPassword(password.text)) {
                              signUpRepository
                                  .signUp(new SignUpRequest(
                                name.text.toString(),
                                email.text.toString(),
                                phone.text.toString(),
                                password.text.toString(),
                              ))
                                  .then((value) {
                                if (value.success) {
                                  Navigator.pushAndRemoveUntil(
                                      context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                                } else {
                                  Fluttertoast.showToast(msg: 'Error occurred.');
                                }
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'password should be contain capital letter and small letter and number and unique character.');
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkPassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
