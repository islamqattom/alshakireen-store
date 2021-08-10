import 'package:flutter/widgets.dart';

class ItemProvider extends ChangeNotifier {
  int imagesGroupsCount = 1;

  changeImagesGroupsCount(int value) {
    imagesGroupsCount = value;
    notifyListeners();
  }
}
