class SliderRequest{
  String image;

  SliderRequest(this.image);

  Map<String, String> toJson() =>{
    "image": image,

  };

}
