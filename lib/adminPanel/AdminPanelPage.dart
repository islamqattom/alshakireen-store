import 'package:alshakireen/adminPanel/Slider/AddSliderPage.dart';
import 'package:alshakireen/adminPanel/itemUsers/SoldItemsAdminPage.dart';
import 'package:alshakireen/adminPanel/user/UsersPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';

class AdminPanelPage extends StatefulWidget {
  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}
class _AdminPanelPageState extends State<AdminPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'لوحة التحكم'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            height: mUtils.height(context, 6),
          ),
          InkWell(
            child: Container(
              height: mUtils.height(context, 51),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Icon(Icons.arrow_back_ios, color: cUtils.green),
                  ),
                  Spacer(),
                  Text('العناصر المباعة'),
                  SizedBox(
                    width: mUtils.width(context, 13),
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                    height: mUtils.height(context, 32),
                    width: mUtils.width(context, 32),
                    margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: cUtils.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: ()=>mUtils.navigatorWithBack(context, SoldItemsAdminPage()),
          ),
          SizedBox(
            height: 3,
          ),
          InkWell(
            child: Container(
              height: mUtils.height(context, 51),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Icon(Icons.arrow_back_ios, color: cUtils.green),
                  ),
                  Spacer(),
                  Text('المستخدمين'),
                  SizedBox(
                    width: mUtils.width(context, 13),
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                    height: mUtils.height(context, 32),
                    width: mUtils.width(context, 32),
                    margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                    child: Icon(
                      Icons.person,
                      color: cUtils.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => mUtils.navigatorWithBack(context, UsersPage()),
          ),
          SizedBox(height: 3),
          InkWell(
            child: Container(
              height: mUtils.height(context, 51),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Icon(Icons.arrow_back_ios, color: cUtils.green),
                  ),
                  Spacer(),
                  Text('إضافة صورة'),
                  SizedBox(
                    width: mUtils.width(context, 17),
                  ),
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                      height: mUtils.height(context, 32),
                      width: mUtils.width(context, 32),
                      margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.slideshow,
                        color: cUtils.primary,
                        size: 20,
                      )),
                ],
              ),
            ),
            onTap: () => mUtils.navigatorWithBack(context, AddSliderPage()),
          ),
          // InkWell(
          //   child: Container(
          //     height: mUtils.height(context, 51),
          //     color: Colors.white,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Icon(Icons.arrow_back_ios, color: cUtils.green),
          //         SizedBox(
          //           width: mUtils.width(context, 160),
          //         ),
          //         Text('إضافة الأصناف الفرعية'),
          //         SizedBox(
          //           width: mUtils.width(context, 17),
          //         ),
          //         Container(
          //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
          //             height: mUtils.height(context, 32),
          //             width: mUtils.width(context, 32),
          //             margin: EdgeInsets.only(right: mUtils.width(context, 13)),
          //             padding: EdgeInsets.all(5),
          //             child: Icon(
          //               Icons.admin_panel_settings,
          //               color: cUtils.primary,
          //               size: 20,
          //             )),
          //       ],
          //     ),
          //   ),
          //   onTap: () =>mUtils.navigatorWithBack(context, ),
          // ),
        ],
      ),
    );
  }
}
