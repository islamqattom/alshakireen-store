import 'package:alshakireen/item/ItemPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alshakireen/items/models/SpecificItems.dart' as SI;
import 'package:alshakireen/item/models/SoldItems.dart' as Sold;

class ItemItems {
  Widget more(BuildContext context, SI.Datum item) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          color: Colors.white,
          height: mUtils.height(context, 170),
          width: mUtils.width(context, 135),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                ],
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
                        '${item.color.length} ألوان ',
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
                          ' ${item.price} JOD',
                          style: TextStyle(color: cUtils.primary, fontSize: 12, fontFamily: 'cairob'),
                        ),
                        Icon(Icons.add, color: cUtils.green),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => mUtils.navigatorWithBack(context, ItemPage(item.id)),
        );
  }

  Widget sold(BuildContext context, Sold.Datum item) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          color: Colors.white,
          height: mUtils.height(context, 170),
          width: mUtils.width(context, 135),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: vUtils.baseItemsImageUrl + item.itemImage,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      height: mUtils.height(context, 100),
                      width: mUtils.width(context, 135),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.itemName,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: cUtils.green, fontSize: 12, fontFamily: 'cairob'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.itemPrice} JD',
                          style: TextStyle(color: cUtils.primary, fontSize: 12, fontFamily: 'cairob'),
                        ),
                        Icon(Icons.add, color: cUtils.green),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => mUtils.navigatorWithBack(context, ItemPage(item.itemId)),
        );
  }
}

ItemItems iItems = ItemItems();
