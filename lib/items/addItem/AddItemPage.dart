import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:alshakireen/items/addItem/AddItemRequest.dart' as AIR;
import 'package:alshakireen/items/addItem/ItemModel.dart';
import 'package:alshakireen/items/provider/ItemProvider.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'AddItemRepository.dart';

class AddItemPage extends StatefulWidget {
  int scId;

  AddItemPage(this.scId);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: AddItemScreen(widget.scId),
    );
  }
}

class AddItemScreen extends StatefulWidget {
  int scId;

  AddItemScreen(this.scId);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController counter = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Asset> imagesAsset = <Asset>[];
  List<String> images = <String>[];
  List<ItemModel> imagesModel = <ItemModel>[];
  String _error = 'No Error Detected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'الفئات'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: name,
                  decoration: InputDecoration(hintText: 'إسم الصنف'),
                ),
              ),
              SizedBox(height: mUtils.height(context, 10)),
              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: price,
                  decoration: InputDecoration(hintText: 'السعر'),
                ),
              ),
              SizedBox(height: mUtils.height(context, 10)),
              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  controller: description,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintStyle: TextStyle(), hintText: 'تفاصيل المنتج'),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
              ),
              Consumer<ItemProvider>(builder: (context, provider, child) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        controller: counter,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(hintStyle: TextStyle(), hintText: 'عدد ألوان المنتج'),
                        onChanged: (value) {
                          provider.changeImagesGroupsCount(int.parse(value.toString()));
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          imagesModel.add(ItemModel(null, <String>[], <Asset>[]));
                          return item(position);
                        },
                        itemCount: provider.imagesGroupsCount,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: mUtils.height(context, 10)),
              InkWell(
                child: Container(
                    margin: const EdgeInsets.only(left: 83, right: 83),
                    color: cUtils.primary,
                    height: mUtils.height(context, 39),
                    width: mUtils.width(context, 251),
                    child: Center(
                        child: Text(
                      "إضافة",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'cairob'),
                    ))),
                onTap: () {
                  List<AIR.Image> images = <AIR.Image>[];
                  for (var i = 0; i < int.parse(counter.text); ++i) {
                    var o = imagesModel[i];
                    images.add(AIR.Image(color: o.color.toString().replaceFirst('Color(', '').replaceFirst(')', ''), image: o.images));
                  }
                  AIR.AddItemRequest addItemRequest = AIR.AddItemRequest(
                    name: name.text,
                    images: images,
                    subcategoryId: widget.scId,
                    description: description.text,
                    status: 0,
                    price: double.parse(price.text),
                  );
                  aIRepository.addItem(addItemRequest).then((value) {
                    if (value.success) {
                      name.text = '';
                      price.text = '';
                      color.text = '';
                      description.text = '';
                      Provider.of<ItemProvider>(context, listen: false).changeImagesGroupsCount(0);
                      setState(() {
                        imagesModel = <ItemModel>[];
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value.information),
                      duration: Duration(seconds: 3),
                    ));
                  });
                },
              ),
              SizedBox(height: mUtils.height(context, 16)),
            ],
          ),
        ),
      ),
    );
  }

  item(int position) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                wUtils.text('اللون :'),
                Icon(Icons.format_color_fill, color: imagesModel[position].color != null ? imagesModel[position].color : Colors.grey)
              ],
            ),
            onTap: () => showPicker(position),
          ),
          imagesModel[position].assetsImages.length > 0
              ? GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(
                    imagesModel[position].assetsImages.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: AssetThumb(
                          asset: imagesModel[position].assetsImages[index],
                          width: imagesModel[position].assetsImages[index].originalWidth,
                          height: imagesModel[position].assetsImages[index].originalHeight,
                        ),
                      );
                    },
                  ),
                )
              : InkWell(
                  child: Center(
                    child: Icon(Icons.image_outlined),
                  ),
                  onTap: () => loadAssets(position),
                ),
        ],
      ),
    );
  }

  // create some values
  Color pickerColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

// raise the [showDialog] widget
  showPicker(int position) {
    // imagesModel[position].color = currentColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: Color(0xff443a49),
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => imagesModel[position].color = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> loadAssets(int position) async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    imagesAsset.clear();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: imagesAsset,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#79A220",
          actionBarTitle: "alshakireen",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#9DA3B4",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print('im in catch: $error');
    }

    if (!mounted) return;
    for (var i = 0; i < resultList.length; ++i) {
      getImageFileFromAssets(resultList[i]).then((value) async {
        File imageFile = new File(value.path);
        File compressedFile = await FlutterNativeImage.compressImage(imageFile.path, quality: 50);
        List<int> imageBytes = compressedFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        imagesModel[position].images.add(base64Image);
      });
    }

    setState(() {
      imagesModel[position].assetsImages = resultList;
    });

    _error = error;
    print(error);
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile = File("${(await getTemporaryDirectory()).path}/${asset.name}");

    final file = await tempFile.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
