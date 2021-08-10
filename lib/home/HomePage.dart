import 'package:alshakireen/adminPanel/slider/SliderModel.dart';
import 'package:alshakireen/adminPanel/Slider/SliderRepository.dart';
import 'package:alshakireen/home/HomePageItems.dart';
import 'package:alshakireen/home/HomeRepository.dart';
import 'package:alshakireen/home/models/Category.dart';
import 'package:alshakireen/home/models/HomeItems.dart';
import 'package:alshakireen/subCategories/SubCategoriesPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SliderModel sliderModel = SliderModel();

  @override
  void initState() {

    super.initState();
    getSliderImages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:wUtils.appBar(context, 'الرئيسية'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
          future: homeRepository.getHomeItems(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return wUtils.text('لا يوجد بيانات.', color: Colors.grey.shade700);
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    HomeItems items = snapshot.data;
                    List<Category> categories = <Category>[];
                    for (var z = 0; z < items.data.length; ++z) {
                      var o = items.data[z];
                      Category category = Category(o.id.toString(), o.name, o.icon);
                      categories.add(category);
                    }

                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///header
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              color: cUtils.primary,
                              height: mUtils.height(context, 40),
                              child: Center(
                                child: TextField(
                                  style: TextStyle(color: cUtils.green, fontFamily: 'cairob'),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'بحث',
                                    contentPadding: EdgeInsets.only(right: 20, bottom: 10),
                                    suffixIcon: Icon(Icons.search, color: cUtils.green),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: mUtils.height(context, 150),
                              width: MediaQuery.of(context).size.width,
                              child: hItem.slider(sliderModel.data),
                            ),
                            Container(
                              color: Colors.white,
                              // height: mUtils.height(context, 132),
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Wrap(
                                  runSpacing: 4,
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                    categories.length,
                                    (index) {
                                      return InkWell(
                                        child: Container(
                                          width: (MediaQuery.of(context).size.width - 3 * (0 - 15)) / 5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: mUtils.width(context, 40),
                                                height:mUtils.height(context, 40),
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: cUtils.primary,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(12),
                                                      topRight: Radius.circular(12),
                                                      bottomLeft: Radius.circular(12),
                                                      bottomRight: Radius.circular(24)),
                                                ),
                                                // child: Icon(Icons.home_outlined,size: 35,color: Colors.white,),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: vUtils.baseCatsImageUrl + categories[index].icon,
                                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ),
                                                ),

                                              Center(child: wUtils.text(categories[index].name)),
                                              SizedBox(height: 4),
                                            ],
                                          ),
                                        ),
                                        onTap: () => mUtils.navigatorWithBack(context, SubCategoriesPage(int.parse(categories[index].id))),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 60),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, position) {
                                  return hItem.item(context, items.data[position]);
                                },
                                itemCount: items.data.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: wUtils.text('لا يوجد بيانات.', color: Colors.grey.shade700));
                  }
                } else {
                  return Center(child: wUtils.text('حدث خطأ ما.', color: Colors.grey.shade700));
                }
                break;
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  getSliderImages() async {
    await sRepository.getSlider().then((value) {
      if (value.success) {
        sliderModel = value;
      }
    });
  }
}
