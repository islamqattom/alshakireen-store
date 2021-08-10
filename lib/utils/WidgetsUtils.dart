import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsUtils {
  text(String msg, {Color color = Colors.black, String font = 'r', double size = 14, TextAlign align = TextAlign.center}) {
    return Text(
      msg,
      textAlign: align,
      style: TextStyle(fontFamily: 'cairo$font', color: color, fontSize: size),
    );
  }

  appBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(color: cUtils.green, fontFamily: 'Cairob'),
              )),
          SizedBox(width: 10),
          Container(
            color: cUtils.green,
            height: mUtils.height(context, 31),
            width: mUtils.width(context, 1),
          ),
          SizedBox(width: 10),
          Image.asset(
            'assets/images/logo.png',
            height: mUtils.height(context, 35),
            width: mUtils.width(context, 36),
            fit: BoxFit.contain,
          )
        ],
      ),
      iconTheme: IconThemeData(color: cUtils.green),
    );
  }
}

WidgetsUtils wUtils = WidgetsUtils();
