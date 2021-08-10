// To parse this JSON data, do
//
//     final oneItem = oneItemFromJson(jsonString);

import 'dart:convert';

OneItem oneItemFromJson(String str) => OneItem.fromJson(json.decode(str));

String oneItemToJson(OneItem data) => json.encode(data.toJson());

class OneItem {
  OneItem({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  Data data;

  factory OneItem.fromJson(Map<String, dynamic> json) => OneItem(
    success: json["success"],
    information: json["information"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "information": information,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.subcategoryId,
    this.description,
    this.status,
    this.price,
    this.liked,
    this.colorImages,
  });

  int id;
  String name;
  int subcategoryId;
  String description;
  int status;
  double price;
  bool liked;
  List<ColorImage> colorImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    subcategoryId: json["subcategory_id"],
    description: json["description"],
    status: json["status"],
    price: json["price"].toDouble(),
    liked: json["liked"],
    colorImages: List<ColorImage>.from(json["colorImages"].map((x) => ColorImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subcategory_id": subcategoryId,
    "description": description,
    "status": status,
    "price": price,
    "liked": liked,
    "colorImages": List<dynamic>.from(colorImages.map((x) => x.toJson())),
  };
}

class ColorImage {
  ColorImage({
    this.id,
    this.itemId,
    this.color,
    this.images,
  });

  int id;
  String itemId;
  String color;
  List<String> images;

  factory ColorImage.fromJson(Map<String, dynamic> json) => ColorImage(
    id: json["id"],
    itemId: json["item_id"],
    color: json["color"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "color": color,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
