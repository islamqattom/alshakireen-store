import 'dart:developer';

import 'package:alshakireen/item/models/Cart.dart';
import 'package:alshakireen/item/models/OneItem.dart';
import 'package:alshakireen/item/models/SoldItems.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class ItemRepository {
  Future<GeneralResponse> addToCart(Cart cart) async {
    String url = '${vUtils.baseUrl}addCart';

    var response = await http.post(Uri.parse(url), body: cart.toJson());
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }

  Future<SoldItems> getSoldItems() async {
    String url = '${vUtils.baseUrl}getSold';

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    log(response.body);

    SoldItems soldItems = SoldItems(success: false, information: 'error occurred', data: null);
    if (response.statusCode == 200) {
      soldItems = soldItemsFromJson(response.body);
    }

    return soldItems;
  }

  Future<OneItem> getOneItem(int itemId, int userId) async {
    String url = '${vUtils.baseUrl}showOneItem/$itemId/$userId';

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    log(response.body);

    OneItem oneItem = OneItem(success: false, information: 'error occurred', data: null);
    if (response.statusCode == 200) {
      oneItem = oneItemFromJson(response.body);
    }

    return oneItem;
  }
}

ItemRepository iRepository = ItemRepository();
