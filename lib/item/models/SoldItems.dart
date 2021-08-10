import 'dart:convert';

SoldItems soldItemsFromJson(String str) => SoldItems.fromJson(json.decode(str));

String soldItemsToJson(SoldItems data) => json.encode(data.toJson());

class SoldItems {
  SoldItems({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  List<Datum> data;

  factory SoldItems.fromJson(Map<String, dynamic> json) => SoldItems(
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
    this.userId,
    this.itemId,
    this.quantity,
    this.color,
    this.status,
    this.itemName,
    this.itemPrice,
    this.itemImage,
  });

  int id;
  int userId;
  int itemId;
  int quantity;
  String color;
  int status;
  String itemName;
  double itemPrice;
  String itemImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        itemId: json["item_id"],
        quantity: json["quantity"],
        color: json["color"],
        status: json["status"],
        itemName: json["item_name"],
        itemPrice: json["item_price"].toDouble(),
        itemImage: json["item_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "item_id": itemId,
        "quantity": quantity,
        "color": color,
        "status": status,
        "item_name": itemName,
        "item_price": itemPrice,
        "item_image": itemImage,
      };
}
