import 'dart:developer';

import 'package:alshakireen/login/LoginRequest.dart';
import 'package:alshakireen/login/LoginResponse.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<LoginResponse> login(LoginRequest user) async {
    String url = '${vUtils.baseUrl}login';

    var response = await http.post(Uri.parse(url), body: user.toJson());
    log('response: ${response.body}');

    LoginResponse loginResponse = LoginResponse(success: false, information: null);
    if (response.statusCode == 200) {
      loginResponse = loginResponseFromJson(response.body);
    } else
      Exception('failed to load data');

    return loginResponse;
  }
}

LoginRepository loginRepository = LoginRepository();
