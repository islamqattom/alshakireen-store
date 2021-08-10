import 'dart:convert';
import 'package:alshakireen/SignUp/SignUpRequest.dart';
import 'package:alshakireen/SignUp/SignUpResponse.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:http/http.dart' as http;

class SignUpRepository {
  Future<SignUpResponse> signUp(SignUpRequest user) async {
    String url = '${vUtils.baseUrl}addUser';

    var response = await http.post(Uri.parse(url), body: user.toJson());

    SignUpResponse signUpResponse = SignUpResponse(false, 'error occurred');
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      signUpResponse =
          SignUpResponse(jsonData['success'], jsonData['information']);
    }

    return signUpResponse;
  }
}

SignUpRepository signUpRepository = SignUpRepository();