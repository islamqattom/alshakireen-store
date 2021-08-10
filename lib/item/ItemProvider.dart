import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  ///like button
  bool isLiked = false;

  changeLiked(bool value) {
    isLiked = value;
    notifyListeners();
  }

  ///images
  List<String> images = <String>[];
  int selectedColor = 0;

  changeImagesGroup(List<String> value, int sColor) {
    images = value;
    selectedColor = sColor;
    notifyListeners();
  }
}
