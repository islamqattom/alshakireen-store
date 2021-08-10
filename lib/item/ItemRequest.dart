class ItemRequest {
  String name;
  String image;
  String description;
  int status;
  double price;

  ItemRequest(this.name, this.image, this.description, this.status, this.price);

  Map<String, String> toJson() => {
        "name": name,
        "image": image,
        "description": description,
      };
}
