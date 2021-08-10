import 'dart:convert';

SpecificItems specificItemsFromJson(String str) => SpecificItems.fromJson(json.decode(str));

String specificItemsToJson(SpecificItems data) => json.encode(data.toJson());

class SpecificItems {
  SpecificItems({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  List<Datum> data;

  factory SpecificItems.fromJson(Map<String, dynamic> json) => SpecificItems(
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
    this.name,
    this.subcategoryId,
    this.description,
    this.status,
    this.price,
    this.colors,
    this.color,
    this.image,
  });

  int id;
  String name;
  int subcategoryId;
  String description;
  int status;
  double price;
  int colors;
  String color;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        subcategoryId: json["subcategory_id"],
        description: json["description"],
        status: json["status"],
        price: json["price"].toDouble(),
        colors: json["colors"],
        color: json["color"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subcategory_id": subcategoryId,
        "description": description,
        "status": status,
        "price": price,
        "colors": colors,
        "color": color,
        "image": image,
      };
}
