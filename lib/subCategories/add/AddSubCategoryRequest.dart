class AddSubCategoryRequest{
  String image;
  String name;
  String category_id;


  AddSubCategoryRequest(this.image, this.name, this.category_id);

  Map<String, String> toJson() =>
      {
        "image": image,
        "name": name,
        "category_id":category_id
      };
}