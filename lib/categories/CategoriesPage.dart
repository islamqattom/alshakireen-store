import 'package:alshakireen/categories/Categories.dart';
import 'package:alshakireen/categories/CategoriesRepository.dart';
import 'package:alshakireen/categories/addCategory/AddCategoryPage.dart';
import 'package:alshakireen/subCategories/SubCategoriesPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'الأصناف'),
      body: FutureBuilder(
        future: cRepository.getCategories(),
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
                  Categories categories = snapshot.data;
                  return GridView.count(
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    primary: false,
                    children: List.generate(categories.data.length, (position) {
                      return InkWell(
                        child: Hero(
                          tag: 'category${categories.data[position].id}',
                          child: Container(
                            height: mUtils.height(context, 180),
                            width: mUtils.width(context, 160),
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(height: mUtils.height(context, 35)),
                                Container(
                                  width: 160,
                                  height: 120,
                                  child: CachedNetworkImage(
                                    imageUrl:  vUtils.baseCatsImageUrl + categories.data[position].image,
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    fit: BoxFit.fill,
                                    ),
                                  ),
                                Text(
                                  categories.data[position].name,
                                  style: TextStyle(color: Color(0xff444343), fontSize: 17, fontFamily: 'Cairob'),
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
                                  onTap: () => cRepository.deleteCategory(categories.data[position].id).then((value) {
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
                        ),
                        onTap: () => mUtils.navigatorWithBack(context, SubCategoriesPage(categories.data[position].id)),
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
      ),
      floatingActionButton: VariablesUtils.isAdmin
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 64),
              child: InkWell(
                child: FloatingActionButton(
                  backgroundColor: cUtils.primary,
                  child: Icon(Icons.add, size: 30),
                ),
                onTap: () => mUtils.navigatorWithBack(context, AddCategoryPage()),
              ))
          : Container(),
    );
  }
}
