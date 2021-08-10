import 'dart:convert';

Favourites favouritesFromJson(String str) => Favourites.fromJson(json.decode(str));

String favouritesToJson(Favourites data) => json.encode(data.toJson());

class Favourites {
  Favourites({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  List<Datum> data;

  factory Favourites.fromJson(Map<String, dynamic> json) => Favourites(
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
    this.userName,
    this.itemName,
    this.itemColors,
    this.itemPrice,
    this.itemImage,
  });

  int id;
  String userId;
  String itemId;
  String userName;
  String itemName;
  int itemColors;
  double itemPrice;
  String itemImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        itemId: json["item_id"],
        userName: json["user_name"],
        itemName: json["item_name"],
        itemColors: json["item_colors"],
        itemPrice: json["item_price"].toDouble(),
        itemImage: json["item_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "item_id": itemId,
        "user_name": userName,
        "item_name": itemName,
        "item_colors": itemColors,
        "item_price": itemPrice.toDouble(),
        "item_image": itemImage,
      };
}
