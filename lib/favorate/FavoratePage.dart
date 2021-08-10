import 'package:alshakireen/favorate/Favourites.dart';
import 'package:alshakireen/favorate/FavorateRepository.dart';
import 'package:alshakireen/item/ItemPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alshakireen/items/models/SpecificItems.dart' as SI;

class FavoratePage extends StatefulWidget {
  @override
  _FavoratePageState createState() => _FavoratePageState();
}

class _FavoratePageState extends State<FavoratePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: wUtils.appBar(context, 'المفضلة'),
        body: FutureBuilder(
            future: fRepository.getFavourites(VariablesUtils.user.id.toString()),
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
                      Favourites favourites = snapshot.data;
                      return GridView.count(
                        padding: const EdgeInsets.all(15),
                        shrinkWrap: true,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        primary: false,
                        children: List.generate(favourites.data.length, (position) {
                          Datum favourite = favourites.data[position];
                          return InkWell(
                            child: Container(
                              height: mUtils.height(context, 200),
                              width: mUtils.width(context, 180),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl: vUtils.baseItemsImageUrl + favourites.data[position].itemImage,
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),

                                          height: mUtils.height(context, 100),
                                          width: mUtils.width(context, 180),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(alignment: Alignment.topRight, child: Icon(Icons.star, color: cUtils.primary)),
                                      ),
                                    ],
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Text(
                                            favourites.data[position].itemName,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: cUtils.green, fontSize: 14, fontFamily: 'cairob'),
                                          ),
                                          SizedBox(height: 2),
                                          Container(
                                            height: mUtils.height(context, 18),
                                            width: mUtils.width(context, 40),
                                            color: Color(0xffEEEEEE),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'ألوان '+favourites.data[position].itemColors.toString() ,
                                              style: TextStyle(
                                                color: cUtils.green,
                                                fontSize: 10,
                                                fontFamily: 'cairob',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${favourites.data[position].itemPrice} JOD',
                                                style: TextStyle(color: cUtils.primary, fontSize: 14, fontFamily: 'cairob'),
                                              ),
                                              Icon(Icons.add, color: cUtils.green),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              mUtils.navigatorWithBack(context, ItemPage(int.parse(favourite.itemId)));
                            },
                          );
                        }),
                      );
                    } else {
                      return Center(child: wUtils.text("لا توجد بيانات"));
                    }
                  } else {
                    return Center(child: wUtils.text("حدث خطأ ما"));
                  }
                  break;
              }

              return Center(child: CircularProgressIndicator());
            }));
  }
}
