import 'package:alshakireen/basket/BasketPage.dart';
import 'package:alshakireen/categories/CategoriesPage.dart';
import 'package:alshakireen/favorate/FavoratePage.dart';
import 'package:alshakireen/home/HomePage.dart';
import 'package:alshakireen/profile/ProfilePage.dart';
import 'package:alshakireen/sharedScreen/AppIcons.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavWidget extends StatefulWidget {
  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  Widget screen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        margin: EdgeInsets.symmetric(horizontal: mUtils.width(context, 22)),
        width: MediaQuery.of(context).size.width,
        height: mUtils.height(context, 44),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: cUtils.green,
                  size: mUtils.height(context, 20),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BasketPage()));
                }),
            IconButton(
                icon: Icon(
                  Icons.star_border_outlined,
                  color: cUtils.green,
                ),
                onPressed: () {
                  setState(() {
                    screen = FavoratePage();
                  });
                }),
            IconButton(
                icon: Icon(Icons.home_outlined, color: cUtils.green),
                onPressed: () {
                  setState(() {
                    screen = HomePage();
                  });
                }),
            IconButton(
                icon: Icon(AppIcons.th_thumb_empty,
                    size: 20, color: cUtils.green),
                onPressed: () => setState(() => screen = CategoriesPage())),
            IconButton(
                icon: Icon(Icons.person_outline, color: cUtils.green),
                onPressed: () {
                  setState(() {
                    screen = ProfilePage();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
