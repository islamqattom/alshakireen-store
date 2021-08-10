import 'package:flutter/material.dart';

class MethodsUtils {
  double height(BuildContext context, double height) {
    double wHeight = height / 736;
    return MediaQuery.of(context).size.height * wHeight;
  }

  double width(BuildContext context, double width) {
    double wWidth = width / 414;
    return MediaQuery.of(context).size.width * wWidth;
  }

  navigator(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  navigatorWithBack(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

MethodsUtils mUtils = MethodsUtils();
