
import 'dart:convert';
import 'dart:developer';
import 'package:alshakireen/subCategories/SubCategories.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

import 'add/AddSubCategoryRequest.dart';
class SubCategoriesRepository{

  Future<SubCategories> getSubCategories(int catID) async{
    String url='${vUtils.baseUrl}getSubCategories/$catID';

    var response=await http.get(Uri.parse(url));
    log(response.body.toString());

    SubCategories subCategories = SubCategories();
    if (response.statusCode == 200) {
      subCategories = subCategoriesFromJson(response.body);
    }
    return subCategories;
  }

  Future<GeneralResponse> addSubCategory(AddSubCategoryRequest addSubCategoryRequest) async{
    String url='${vUtils.baseUrl}addSubCategory';

    var response=await http.post(Uri.parse(url),body: addSubCategoryRequest.toJson());
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }

  Future<GeneralResponse> deleteSubCategory(int id) async {
    String url = '${vUtils.baseUrl}deleteSubCategory/$id';

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

SubCategoriesRepository scRepository = SubCategoriesRepository();