import 'dart:developer';

import 'package:alshakireen/favorate/Favourites.dart';
import 'package:alshakireen/favorate/FavorateRequest.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class FavorateRepository {
  Future<GeneralResponse> addFavorate(FavorateRequest favorate) async {
    String url = '${vUtils.baseUrl}addFavorate';

    var response = await http.post(Uri.parse(url), body: favorate.toJson());
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }

  Future<Favourites> getFavourites(String userId) async {
    String url = '${vUtils.baseUrl}getFavorates/$userId';

    var response = await http.get(Uri.parse(url));
    log(response.body.toString());

    Favourites favourites = Favourites();
    if (response.statusCode == 200) {
      favourites = favouritesFromJson(response.body);
    }
    return favourites;
  }
}

FavorateRepository fRepository = FavorateRepository();
