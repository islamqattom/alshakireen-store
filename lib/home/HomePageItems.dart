import 'package:alshakireen/adminPanel/slider/SliderModel.dart' as S;
import 'package:alshakireen/home/models/HomeItems.dart';
import 'package:alshakireen/item/ItemPage.dart';
import 'package:alshakireen/item/models/Cart.dart';
import 'package:alshakireen/item/network/ItemRepository.dart';
import 'package:alshakireen/subCategories/SubCategoriesPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageItems {
  item(BuildContext context, Datum item) {
    return item.items.length > 0
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(item.name, style: TextStyle(color: cUtils.green, fontSize: 14, fontFamily: 'cairob')),
                    Spacer(),
                    InkWell(
                      child: Text('عرض الكل >', style: TextStyle(color: Colors.blue, fontSize: 14, fontFamily: 'cairob')),
                      onTap: () => mUtils.navigatorWithBack(context, SubCategoriesPage(item.id)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: mUtils.height(context, 170),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) => hItem.categoryItem(context, item: item.items[position], items: item.items),
                  itemCount: item.items.length,
                ),
              ),
              SizedBox(height: 15)
            ],
          )
        : Container();
  }

  Widget categoryItem(BuildContext context, {Item item, List<Item> items}) {
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
                imageUrl: vUtils.baseItemsImageUrl + item.image,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                height: mUtils.height(context, 100),
                width: mUtils.width(context, 135),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: cUtils.green, fontSize: 12, fontFamily: 'cairob'),
                  ),
                  Container(
                    height: mUtils.height(context, 18),
                    width: mUtils.width(context, 33),
                    color: Color(0xffEEEEEE),
                    alignment: Alignment.center,
                    child: Text(
                      'ألوان' + item.colors.toString(),
                      style: TextStyle(
                        color: cUtils.green,
                        fontSize: 8,
                        fontFamily: 'cairob',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.price} JOD',
                        style: TextStyle(color: cUtils.primary, fontSize: 12, fontFamily: 'cairob'),
                      ),
                      InkWell(
                        child: Icon(Icons.add, color: cUtils.green),
                        onTap: () {
                          Cart cart = Cart(VariablesUtils.user.id.toString(), item.id.toString(), '1', item.color, '0');
                          iRepository.addToCart(cart).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: wUtils.text(value.information, color: Colors.white),
                              duration: Duration(seconds: 3),
                            ));
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => mUtils.navigatorWithBack(context, ItemPage(item.id)),
      // item: item, homeItems: items
    );
  }

  slider(List<S.Datum> images) {
    List<String> newImages = <String>[];
    for (var i = 0; i < images.length; ++i) {
      var o = images[i];
      newImages.add(o.image);
    }

    CarouselController buttonCarouselController = CarouselController();

    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: images.length > 1,
        enlargeCenterPage: true,
        viewportFraction: 1,
        aspectRatio: 2,
      ),
      items: newImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(vUtils.baseSliderImageUrl + i),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

HomePageItems hItem = HomePageItems();
