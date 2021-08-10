import 'dart:convert';

AddItemRequest addItemRequestFromJson(String str) => AddItemRequest.fromJson(json.decode(str));

String addItemRequestToJson(AddItemRequest data) => json.encode(data.toJson());

class AddItemRequest {
  AddItemRequest({
    this.name,
    this.images,
    this.subcategoryId,
    this.description,
    this.status,
    this.price,
  });

  String name;
  List<Image> images;
  int subcategoryId;
  String description;
  int status;
  double price;

  factory AddItemRequest.fromJson(Map<String, dynamic> json) => AddItemRequest(
        name: json["name"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        subcategoryId: json["subcategory_id"],
        description: json["description"],
        status: json["status"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "subcategory_id": subcategoryId,
        "description": description,
        "status": status,
        "price": price,
      };
}

class Image {
  Image({
    this.color,
    this.image,
  });

  String color;
  List<String> image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        color: json["color"],
        image: List<String>.from(json["image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "image": List<dynamic>.from(image.map((x) => x)),
      };
}
