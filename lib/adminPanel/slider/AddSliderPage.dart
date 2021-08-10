import 'dart:convert';
import 'dart:io';
import 'package:alshakireen/adminPanel/Slider/SliderRequest.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'SliderRepository.dart';

class AddSliderPage extends StatefulWidget {
  @override
  _AddSliderPageState createState() => _AddSliderPageState();
}

class _AddSliderPageState extends State<AddSliderPage> {
  List<Asset> mainImage = <Asset>[];
  String _error = 'No Error Detected';
  String base64Image, base64Icon;

  Asset image;

  @override
  Widget build(BuildContext context) {
    setPermissions();
    return Scaffold(
      appBar: wUtils.appBar(context, 'أدخل إعلان'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: mUtils.height(context, 35)),
              InkWell(
                child: Container(
                  height: mUtils.height(context, 150),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: image != null
                      ? AssetThumb(
                    asset: image,
                    height: 200,
                    width: 400,
                    quality: 100,
                  )
                      : Center(
                      child: Text(
                        'أدخل صورة',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                onTap: () => loadAsset(),
              ),
              SizedBox(height: mUtils.height(context, 10)),
              InkWell(
                child: Container(
                    margin: const EdgeInsets.only(left: 83, right: 83),
                    color: cUtils.primary,
                    height: mUtils.height(context, 39),
                    width: mUtils.width(context, 251),
                    child: Center(child: Text("إضافة", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'cairob')))),
                onTap: () {
                  sRepository.addSlider(SliderRequest(base64Image)).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value.information),
                      duration: Duration(seconds: 3),
                    ));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.storage,
    ].request();
  }

  Future<void> loadAsset() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    mainImage.clear();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: false,
        selectedAssets: mainImage,
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
    getImageFileFromAssets(resultList[0]).then((value) async {
      File imageFile = new File(value.path);
      File compressedFile = await FlutterNativeImage.compressImage(imageFile.path, quality: 50);
      List<int> imageBytes = compressedFile.readAsBytesSync();
      base64Image = base64.encode(imageBytes);
    });

    setState(() {
      image = resultList[0];
    });
    // setState(() {
    mainImage = resultList;
    _error = error;
    print(error);
    // });
  }


  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile = File("${(await getTemporaryDirectory()).path}/${asset.name}");

    final file = await tempFile.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
