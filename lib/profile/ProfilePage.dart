import 'package:alshakireen/basket/BasketPage.dart';
import 'package:alshakireen/favorate/FavoratePage.dart';
import 'package:alshakireen/intro/IntroPage.dart';
import 'package:alshakireen/adminPanel/AdminPanelPage.dart';
import 'package:alshakireen/sharedScreen/AppIcons.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'حسابي'),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, textDirection: TextDirection.rtl, children: [
        SizedBox(
          height: mUtils.height(context, 6),
        ),
        Container(
          height: mUtils.height(context, 105),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(
                width: mUtils.width(context, 27),
                height: mUtils.height(context, 19),
              ),
              CircleAvatar(backgroundImage: AssetImage('assets/images/logo.png'), radius: mUtils.width(context, 37.5)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                    child: Text(
                      VariablesUtils.user.name,
                      style: TextStyle(
                        color: cUtils.green,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                    child: Text(
                      VariablesUtils.user.email,
                      style: TextStyle(
                        color: cUtils.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: mUtils.width(context, 140),
              ),
              Icon(
                Icons.arrow_back_ios,
                color: cUtils.green,
              )
            ],
          ),
        ),
        SizedBox(
          height: mUtils.height(context, 34),
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
                Text('طلبات'),
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
          onTap: () => mUtils.navigatorWithBack(context, BasketPage()),
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
                Text('ردود الفعل'),
                SizedBox(
                  width: mUtils.width(context, 13),
                ),
                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                    height: mUtils.height(context, 32),
                    width: mUtils.width(context, 32),
                    margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      AppIcons.heart,
                      color: cUtils.primary,
                      size: 18,
                    )),
              ],
            ),
          ),
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
                Text('المنتجات المفضلة'),
                SizedBox(
                  width: mUtils.width(context, 13),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                  height: mUtils.height(context, 32),
                  width: mUtils.width(context, 32),
                  margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                  child: Icon(
                    Icons.star,
                    color: cUtils.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => mUtils.navigatorWithBack(context, FavoratePage()),
        ),
        SizedBox(
          height: 35,
        ),
        Container(
          height: mUtils.height(context, 114),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Icon(Icons.arrow_back_ios, color: cUtils.green),
              ),
              Spacer(),
              Text('خدمة الزبائن'),
              SizedBox(
                width: mUtils.width(context, 13),
              ),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                  height: mUtils.height(context, 32),
                  width: mUtils.width(context, 32),
                  margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    'assets/images/headset.svg',
                    color: cUtils.primary,
                    width: 15,
                    height: 15,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        VariablesUtils.isAdmin
            ? InkWell(
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
                      Text('لوحة التحكم'),
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                          height: mUtils.height(context, 32),
                          width: mUtils.width(context, 32),
                          margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.admin_panel_settings,
                            color: cUtils.primary,
                            size: 20,
                          )),
                    ],
                  ),
                ),
                onTap: () => mUtils.navigatorWithBack(context, AdminPanelPage()),
              )
            : Container(),
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
                Text('تسجيل الخروج'),
                SizedBox(
                  width: mUtils.width(context, 13),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Color(0x33feae01)),
                  height: mUtils.height(context, 32),
                  width: mUtils.width(context, 32),
                  margin: EdgeInsets.only(right: mUtils.width(context, 13)),
                  child: Icon(
                    Icons.logout,
                    color: cUtils.primary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            _prefs.setString('user', '');
            if (_prefs.getString('user') == '')
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => IntroPage()), (route) => false);
          },
        )
      ]),
    );
  }
}
