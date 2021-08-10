import 'dart:convert';
import 'dart:developer';
import 'package:alshakireen/items/addItem/AddItemRequest.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class AddItemRepository {
  Future<GeneralResponse> addItem(AddItemRequest addItemRequest) async {
    print('length: ' + addItemRequest.images.length.toString());
    log(jsonEncode(addItemRequest));

    String url = '${vUtils.baseUrl}addItem';

    var response = await http.post(Uri.parse(url), body: jsonEncode(addItemRequest), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }
}

AddItemRepository aIRepository = AddItemRepository();
