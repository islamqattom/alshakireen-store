import 'package:alshakireen/items/ItemsPage.dart';
import 'package:alshakireen/subCategories/SubCategories.dart';
import 'package:alshakireen/subCategories/SubCategoriesRepository.dart';
import 'package:alshakireen/subCategories/add/AddSubCategoryPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubCategoriesPage extends StatefulWidget {
  int catId;

  SubCategoriesPage(this.catId);

  @override
  _SubCategoriesPageState createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'الأصناف الفرعية'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:FutureBuilder(
        future: scRepository.getSubCategories(widget.catId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: wUtils.text("لا يوجد بيانات"));
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (!snapshot.hasError) {
                if (snapshot.hasData) {
                  SubCategories subCategories = snapshot.data;
                  return GridView.count(
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    primary: false,
                    children: List.generate(subCategories.data.length, (position) {
                      return InkWell(
                        child: Container(
                          height: mUtils.height(context, 200),
                          width: mUtils.width(context, 180),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: mUtils.height(context, 150),
                                child: CachedNetworkImage(imageUrl: vUtils.baseSubCatsImageUrl + subCategories.data[position].image,
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      ),
                              ),

                              Text(
                                subCategories.data[position].name,
                                style: TextStyle(color: Color(0xff444343), fontSize: 18, fontFamily: 'Cairob'),
                              ),
                              VariablesUtils.isAdmin
                                  ?InkWell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SvgPicture.asset(
                                    'assets/images/close.svg',
                                    height: mUtils.width(context, 11),
                                    width: mUtils.height(context, 11),
                                    fit: BoxFit.cover,
                                    color: cUtils.green,
                                  ),
                                ),
                                onTap: () => scRepository.deleteSubCategory(subCategories.data[position].id).then((value) {
                                  if (value.success)
                                    setState(() {});
                                  else {
                                    print('error occurred');
                                  }
                                }),
                              ): Container(),
                            ],
                          ),
                        ),
                        onTap: () => mUtils.navigatorWithBack(context, ItemsPage(subCategories.data[position])),
                      );

                    }),
                  );
                } else {
                  return Center(child: wUtils.text("لا يوجد بيانات"));
                }
              } else {
                return Center(child: wUtils.text("حدث خطأ ما."));
              }
              break;
          }
          return Center(child: CircularProgressIndicator());
        },
      ),),
      floatingActionButton: VariablesUtils.isAdmin
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 64),
              child: InkWell(
                child: FloatingActionButton(
                  backgroundColor: cUtils.primary,
                  child: Icon(Icons.add, size: 30),
                ),
                onTap: () => mUtils.navigatorWithBack(context, AddSubCategoryPage(widget.catId)),
              ))
          : Container(),
    );
  }
}
