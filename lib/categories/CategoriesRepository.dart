import 'dart:convert';
import 'dart:developer';
import 'package:alshakireen/categories/Categories.dart';
import 'package:alshakireen/categories/addCategory/AddCategoryRequest.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class CategoriesRepository {
  Future<Categories> getCategories() async {
    String url = '${vUtils.baseUrl}getCategories';

    var response = await http.get(Uri.parse(url));
    log(response.body.toString());

    Categories categories = Categories(success: false, information: 'error', data: null);
    if (response.statusCode == 200) {
      categories = categoriesFromJson(response.body);
    }
    return categories;
  }

  Future<GeneralResponse> addCategory(AddCategoryRequest addCategoryRequest) async{
    String url='${vUtils.baseUrl}addCategory';

    log("Icon value is ===========>");
    log(addCategoryRequest.icon);
    var response=await http.post(Uri.parse(url),body: addCategoryRequest.toJson());
    log("response body id ---------------->");
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }

  Future<GeneralResponse> deleteCategory(int id) async {
    String url = '${vUtils.baseUrl}deleteCategory/$id';

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

CategoriesRepository cRepository = CategoriesRepository();
