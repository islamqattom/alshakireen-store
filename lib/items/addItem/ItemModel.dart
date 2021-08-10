import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class ItemModel {
  Color color;
  List<String> images;
  List<Asset> assetsImages;

  ItemModel(this.color, this.images, this.assetsImages);
}
