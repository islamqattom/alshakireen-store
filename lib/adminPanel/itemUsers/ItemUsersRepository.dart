import 'dart:developer';

import 'package:alshakireen/adminPanel/itemUsers/ItemUsers.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:http/http.dart' as http;

class ItemUsersRepository {
  Future<ItemUsers> getitemUsers(int itemId) async {
    String url = '${vUtils.baseUrl}getUser/$itemId';

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    log(response.body.toString());

    ItemUsers itemUsers = ItemUsers(success: false, information: 'error', data: null);
    if (response.statusCode == 200) {
      itemUsers = itemUsersFromJson(response.body);
    }
    return itemUsers;
  }
}

ItemUsersRepository iURepository=ItemUsersRepository();