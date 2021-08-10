import 'dart:convert';
import 'dart:developer';
import 'package:alshakireen/basket/Basket.dart';
import 'package:alshakireen/item/models/SoldItems.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class BasketRepository {
  Future<Basket> getCart(String userId) async {
    String url = '${vUtils.baseUrl}getCarts/$userId';

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    log(response.body.toString());

    Basket basket = Basket(success: false, information: 'error', data: null);
    if (response.statusCode == 200) {
      basket = basketFromJson(response.body);
    }
    return basket;
  }

  Future<SoldItems> getCarts() async {
    String url = '${vUtils.baseUrl}getCarts';

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    log(response.body.toString());

    SoldItems soldItems = SoldItems(success: false, information: 'error', data: null);
    if (response.statusCode == 200) {
      soldItems = soldItemsFromJson(response.body);
    }
    return soldItems;
  }

  Future<GeneralResponse> deleteCart(int id) async {
    String url = '${vUtils.baseUrl}deleteCart/$id';

    var response = await http.post(Uri.parse(url), headers: {"Accept": "application/json"});

    log(response.body.toString());

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error');
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      generalResponse = GeneralResponse(success: jsonData['success'], information: jsonData['information']);
    }
    return generalResponse;
  }
}

BasketRepository bRepository = BasketRepository();
