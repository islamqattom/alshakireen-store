import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  List<Datum> data;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        success: json["success"],
        information: json["information"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "information": information,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.image,
  });

  int id;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Image": image,
      };
}
