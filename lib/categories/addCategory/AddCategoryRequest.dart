class AddCategoryRequest {
  String name;
  String image;
  String icon;


  AddCategoryRequest(this.name, this.image, this.icon);

  Map<String, String> toJson() => {
        "name": name,
        "image": image,
        "icon": icon,
      };
}
