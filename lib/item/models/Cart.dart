class Cart {
  String userId;
  String itemId;
  String quantity;
  String color;
  String status;

  Cart(this.userId, this.itemId, this.quantity, this.color, this.status);

  Map<String, String> toJson() => {
        "user_id": userId,
        "item_id": itemId,
        "quantity": quantity,
        "color": color,
        "status": status,
      };
}
