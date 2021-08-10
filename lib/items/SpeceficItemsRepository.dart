import 'dart:convert';
import 'dart:developer';

import 'package:alshakireen/items/models/SpecificItems.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class SpeceficItemsRepository {
  Future<SpecificItems> getSpecificItems(int id) async {
    String url = '${vUtils.baseUrl}getSpesificItems/$id';

    var response = await http.get(Uri.parse(url));
    log(response.body);

    SpecificItems specificItems = SpecificItems(success: false, information: 'error occurred', data: null);
    if (response.statusCode == 200) {
      specificItems = specificItemsFromJson(response.body);
    }
    return specificItems;
  }

  Future<GeneralResponse> deleteItem(int id) async {
    String url = '${vUtils.baseUrl}deleteItem/$id';

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

SpeceficItemsRepository siRepository = SpeceficItemsRepository();
