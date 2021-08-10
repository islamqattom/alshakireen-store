import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) => GeneralResponse.fromJson(json.decode(str));

class GeneralResponse {
  bool success;
  String information;

  GeneralResponse({this.success, this.information});

  factory GeneralResponse.fromJson(Map<String, dynamic> json) => GeneralResponse(
        success: json['success'],
        information: json['information'],
      );
}
