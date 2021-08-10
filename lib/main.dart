import 'dart:ui';

import 'package:alshakireen/splashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffF0A400),
        accentColor: Colors.pink,
        primarySwatch: Colors.blue,
        fontFamily: 'cairob',
        scaffoldBackgroundColor: Color(0xffF6F6F6)
      ),
      home: SplashScreen(),
    );
  }
}
