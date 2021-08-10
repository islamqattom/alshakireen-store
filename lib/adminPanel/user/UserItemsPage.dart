import 'package:alshakireen/adminPanel/user/UserItems.dart';
import 'package:alshakireen/adminPanel/user/UserRepository.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserItemsPage extends StatefulWidget {
  int sId;

  UserItemsPage(this.sId);

  @override
  _UserItemsPageState createState() => _UserItemsPageState();
}

class _UserItemsPageState extends State<UserItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'المنتجات المباعة '),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
              future: uRepository.getUserItems(widget.sId),
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
                        UserItems userItems = snapshot.data;
                        return GridView.count(
                          padding: const EdgeInsets.all(15),
                          shrinkWrap: true,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          primary: false,
                          children: List.generate(userItems.data.length, (position) {
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.white,
                                height: mUtils.height(context, 170),
                                width: mUtils.width(context, 135),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CachedNetworkImage(
                                        imageUrl: vUtils.baseItemsImageUrl + userItems.data[position].itemImage,
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
                                            userItems.data[position].itemName,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: cUtils.green, fontSize: 12, fontFamily: 'cairob'),
                                          ),
                                          Container(
                                            height: mUtils.height(context, 18),
                                            width: mUtils.width(context, 50),
                                            color: Color(0xffEEEEEE),
                                            alignment: Alignment.center,
                                            child:  Row(
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
                                                    color: Color(int.parse(userItems.data[position].color)),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ],),
                                          ),
                                          Text(
                                            '${userItems.data[position].itemPrice} JOD',
                                            style: TextStyle(color: cUtils.primary, fontSize: 12, fontFamily: 'cairob'),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // child: Container(
                              //   height: mUtils.height(context, 200),
                              //   width: mUtils.width(context, 180),
                              //   color: Colors.white,
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         height: mUtils.height(context, 150),
                              //         child: Image.network(
                              //           vUtils.baseSubCatsImageUrl + soldItems.data[position].itemImage,
                              //           fit: BoxFit.fill,
                              //         ),
                              //       ),
                              //       Text(
                              //         soldItems.data[position].itemName,
                              //         style: TextStyle(color: Color(0xff444343), fontSize: 20, fontFamily: 'Cairob'),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // onTap: () => mUtils.navigatorWithBack(context, ItemsPage(subCategories.data[position])),
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
          ),
        ),
      ),
      // bottomNavigationBar: Row(textDirection: TextDirection.rtl, children: [
      //   Container(
      //     height: mUtils.height(context, 64),
      //     width: mUtils.width(context, 270),
      //     color: cUtils.primary,
      //     child: Center(
      //       child: Text(
      //         'العدد الإجمالي',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 22,
      //         ),
      //       ),
      //     ),
      //   ),
      //   Container(
      //     padding: EdgeInsets.only(right: 23, top: 10),
      //     alignment: Alignment.centerRight,
      //     height: mUtils.height(context, 64),
      //     width: mUtils.width(context, 144),
      //     color: Colors.white,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [
      //         // Text(
      //         //   'الإجمالي',
      //         //   style: TextStyle(
      //         //     color: Color(0xff444343),
      //         //     fontSize: 12,
      //         //   ),
      //         // ),
      //
      //         Center(
      //           child: Text(
      //             '10',
      //             style: TextStyle(
      //               color: cUtils.green,
      //               fontSize: 25,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ]),
    );
  }
}
