// To parse this JSON data, do
//
//     final homeItems = homeItemsFromJson(jsonString);

import 'dart:convert';

HomeItems homeItemsFromJson(String str) => HomeItems.fromJson(json.decode(str));

String homeItemsToJson(HomeItems data) => json.encode(data.toJson());

class HomeItems {
  HomeItems({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  List<Datum> data;

  factory HomeItems.fromJson(Map<String, dynamic> json) => HomeItems(
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
    this.image,
    this.icon,
    this.items,
  });

  int id;
  String name;
  String image;
  String icon;
  List<Item> items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        icon: json["icon"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "icon": icon,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        subcategoryId: json["subcategory_id"],
        description: json["description"],
        status: json["status"],
        price: json["price"].toDouble(),
        colors: json["colors"],
        color: json["color"] == null ? null : json["color"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subcategory_id": subcategoryId,
        "description": description,
        "status": status,
        "price": price.toDouble(),
        "colors": colors,
        "color": color == null ? null : color,
        "image": image == null ? null : image,
      };
}
