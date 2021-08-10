// To parse this JSON data, do
//
//     final itemUsers = itemUsersFromJson(jsonString);

import 'dart:convert';

ItemUsers itemUsersFromJson(String str) => ItemUsers.fromJson(json.decode(str));

String itemUsersToJson(ItemUsers data) => json.encode(data.toJson());

class ItemUsers {
  ItemUsers({
    this.success,
    this.information,
    this.data,
  });

  bool success;
  String information;
  List<Datum> data;

  factory ItemUsers.fromJson(Map<String, dynamic> json) => ItemUsers(
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
    this.userName,
    this.userPhone,
    this.userEmail,
  });

  int id;
  int userId;
  int itemId;
  int quantity;
  String color;
  int status;
  String userName;
  String userPhone;
  String userEmail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    itemId: json["item_id"],
    quantity: json["quantity"],
    color: json["color"],
    status: json["status"],
    userName: json["user_name"],
    userPhone: json["user_phone"],
    userEmail: json["user_Email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "item_id": itemId,
    "quantity": quantity,
    "color": color,
    "status": status,
    "user_name": userName,
    "user_phone": userPhone,
    "user_Email": userEmail,
  };
}
