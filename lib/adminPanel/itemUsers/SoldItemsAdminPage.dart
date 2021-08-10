import 'package:alshakireen/adminPanel/itemUsers/SoldItemUsersPage.dart';
import 'package:alshakireen/basket/BasketRepository.dart';
import 'package:alshakireen/item/models/SoldItems.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SoldItemsAdminPage extends StatefulWidget {
  @override
  _SoldItemsAdminPageState createState() => _SoldItemsAdminPageState();
}

class _SoldItemsAdminPageState extends State<SoldItemsAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'العناصر المباعة'),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: bRepository.getCarts(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.done:
                    if (!snapshot.hasError) {
                      if (snapshot.hasData) {
                        SoldItems soldItems = snapshot.data;
                        return GridView.count(
                          padding: const EdgeInsets.all(15),
                          shrinkWrap: true,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          primary: false,
                          children: List.generate(soldItems.data.length, (position) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.white,
                                height: mUtils.height(context, 130),
                                width: mUtils.width(context, 135),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CachedNetworkImage(
                                        imageUrl: vUtils.baseItemsImageUrl + soldItems.data[position].itemImage,
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                        height: mUtils.height(context, 100),
                                        width: mUtils.width(context, 180),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            soldItems.data[position].itemName,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: cUtils.green, fontSize: 12, fontFamily: 'cairob'),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: mUtils.width(context, 50),
                                                color: Color(0xffEEEEEE),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: mUtils.width(context, 30),
                                                      color: Color(0xffEEEEEE),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        ' اللون: ',
                                                        style: TextStyle(
                                                          color: cUtils.green,
                                                          fontSize: 8,
                                                          fontFamily: 'cairob',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color: Color(int.parse(soldItems.data[position].color)),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${soldItems.data[position].itemPrice} JOD',
                                                style: TextStyle(color: cUtils.primary, fontSize: 12, fontFamily: 'cairob'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () => mUtils.navigatorWithBack(context, SoldItemUsersPage(soldItems.data[position].itemId)),
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
          )),
    );
  }
}
