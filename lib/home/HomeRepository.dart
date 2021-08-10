import 'dart:developer';
import 'package:alshakireen/home/models/HomeItems.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<HomeItems> getHomeItems() async {
    String url = '${vUtils.baseUrl}getItems';

    var response = await http.get(Uri.parse(url));
    log(response.body.toString());

    HomeItems homeItems = HomeItems();
    if (response.statusCode == 200) {
      homeItems = homeItemsFromJson(response.body);
    }
    return homeItems;
  }
}

HomeRepository homeRepository = HomeRepository();
