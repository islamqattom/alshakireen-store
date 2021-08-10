class BasketRequest {
  String image;
  String name;
  String quantity;
  String price;


  BasketRequest(this.image, this.name, this.quantity, this.price);

  Map<String, String> toJson() => {"name": name, "quantity": quantity, "price": price};
}
