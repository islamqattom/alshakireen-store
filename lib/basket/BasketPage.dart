import 'dart:ffi';

import 'package:alshakireen/basket/Basket.dart';
import 'package:alshakireen/basket/BasketProvider.dart';
import 'package:alshakireen/item/ItemPage.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'BasketRepository.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BasketProvider(),
      child: BasketScreen(),
    );
  }
}

class BasketScreen extends StatefulWidget {
  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  double countPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'السلة'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:SingleChildScrollView(
        child: FutureBuilder(
          future: bRepository.getCart(VariablesUtils.user.id.toString()),
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
                    Basket basket = snapshot.data;
                    List<double> prices = <double>[];
                    for (var i = 0; i < basket.data.length; ++i) {
                      var o = basket.data[i];
                      prices.add(o.itemPrice.toDouble());
                    }
                    Provider.of<BasketProvider>(context, listen: false).changePrice(prices);

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        return InkWell(
                          child: Container(
                            height: mUtils.height(context, 90),
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  width: mUtils.width(context, 125),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(vUtils.baseItemsImageUrl + basket.data[position].itemImage),
                                          fit: BoxFit.fill)),
                                ),
                                SizedBox(width: mUtils.width(context, 10)),
                                Column(
                                  children: [
                                    SizedBox(height: mUtils.height(context, 10)),
                                    Text(
                                      basket.data[position].itemName,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: Color(0xff444343),
                                        fontSize: 9,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'العدد:' + basket.data[position].quantity.toString(),
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: Color(0xb3444343),
                                            fontSize: 9,
                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: mUtils.height(context, 12)),
                                    Container(
                                      alignment: Alignment.center,
                                      color: cUtils.primary,
                                      width: mUtils.width(context, 92),
                                      height: mUtils.height(context, 22),
                                      child: Text(
                                        basket.data[position].itemPrice.toString() + '\$  JOD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                InkWell(
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
                                  onTap: () => bRepository.deleteCart(basket.data[position].id).then((value) {
                                    if (value.success)
                                      setState(() {});
                                    else {
                                      print('error occurred');
                                    }
                                  }),
                                )
                              ],
                            ),
                          ),
                          onTap: () => mUtils.navigatorWithBack(context, ItemPage(basket.data[position].itemId)),
                        );
                      },
                      itemCount: basket.data.length,
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
      ),),
      bottomNavigationBar: Row(textDirection: TextDirection.rtl, children: [
        Container(
          height: mUtils.height(context, 64),
          width: mUtils.width(context, 270),
          color: cUtils.primary,
          child: Center(
            child: Text(
              'الدفع الآمن',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 23, top: 10),
          alignment: Alignment.centerRight,
          height: mUtils.height(context, 64),
          width: mUtils.width(context, 144),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'الإجمالي',
                style: TextStyle(
                  color: Color(0xff444343),
                  fontSize: 12,
                ),
              ),
              Consumer<BasketProvider>(
                builder: (context, provider, child) {
                  return Text(
                    '${provider.price} JOD',
                    style: TextStyle(
                      color: cUtils.primary,
                      fontSize: 14,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

