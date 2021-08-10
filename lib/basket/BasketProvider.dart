import 'package:flutter/material.dart';

class BasketProvider extends ChangeNotifier {
  double price = 0.0;

  changePrice(List<double> prices) {
    price = 0.0;
    for (var i = 0; i < prices.length; ++i) {
      var o = prices[i];
      price += o;
    }
    notifyListeners();
  }
}
