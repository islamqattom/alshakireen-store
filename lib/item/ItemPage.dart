import 'package:alshakireen/comment/CommentPage.dart';
import 'package:alshakireen/favorate/FavorateRepository.dart';
import 'package:alshakireen/favorate/FavorateRequest.dart';
import 'package:alshakireen/item/ItemProvider.dart';
import 'package:alshakireen/item/models/Cart.dart';
import 'package:alshakireen/item/models/OneItem.dart';
import 'package:alshakireen/item/models/SoldItems.dart';
import 'package:alshakireen/item/network/ItemRepository.dart';
import 'package:alshakireen/items/SpeceficItemsRepository.dart';
import 'package:alshakireen/items/models/SpecificItems.dart' as SI;
import 'package:alshakireen/items/ui/ItemItems.dart';
import 'package:alshakireen/subCategories/SubCategoriesPage.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  int itemId;

  ItemPage(this.itemId);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemProvider()),
      ],
      child: ItemScreen(widget.itemId),
    );
  }
}

class ItemScreen extends StatefulWidget {
  int itemId;

  ItemScreen(this.itemId);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int id;
  String selectedColor;
  bool gIsLiked;
  bool firstTime = true;

  ItemProvider globalProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
          future: iRepository.getOneItem(widget.itemId, VariablesUtils.user.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: wUtils.text('nothing to show !'));
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    OneItem item = snapshot.data;
                    id = item.data.id;
                    gIsLiked = item.data.liked;
                    selectedColor = item.data.colorImages[0].color;

                    return Column(
                      children: [
                        ///body
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Consumer<ItemProvider>(builder: (context, provider, child) {
                                  if (provider.images == null || provider.images.length ==0) {
                                    provider.changeImagesGroup(item.data.colorImages[0].images, 0);
                                    print('object');
                                  }
                                  return Container(
                                    height: mUtils.height(context, 237),
                                    width: MediaQuery.of(context).size.width,
                                    child: slider(provider.images),
                                  );
                                }),
                                SizedBox(height: mUtils.height(context, 10)),
                                Container(
                                  padding: EdgeInsets.only(right: mUtils.width(context, 31)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          SizedBox(width: 5),
                                          Text(
                                            item.data.name,
                                            style: TextStyle(
                                              color: Color(0xff444343),
                                              fontSize: 22,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: mUtils.height(context, 35),
                                            width: mUtils.width(context,100),
                                            color: cUtils.green,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${item.data.price} JOD',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: SmoothStarRating(
                                                allowHalfRating: true,
                                                starCount: 5,
                                                size: mUtils.height(context, 20),
                                                isReadOnly: true,
                                                filledIconData: Icons.star,
                                                halfFilledIconData: Icons.star_half,
                                                color: cUtils.primary,
                                                borderColor: cUtils.primary,
                                                spacing: 0.0),
                                          ),
                                          SizedBox(
                                            width: mUtils.width(context, 15),
                                          ),
                                          InkWell(
                                            child: Text(
                                              'عرض التعليقات',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  decoration: TextDecoration.underline,
                                                  fontFamily: 'cairob'),
                                            ),
                                            onTap: () => mUtils.navigatorWithBack(context, CommentPage(item.data.id)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Consumer<ItemProvider>(builder: (context, provider, child) {
                                        return Container(
                                          height: 30,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, position) {
                                              return InkWell(
                                                child: Container(
                                                  height: mUtils.height(context, 31),
                                                  width: mUtils.width(context, 31),
                                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                                  decoration: BoxDecoration(
                                                    color: provider.selectedColor == position ? cUtils.primary : Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    margin: EdgeInsets.all(2),
                                                    height: mUtils.height(context, 30),
                                                    width: mUtils.width(context, 30),
                                                    decoration: BoxDecoration(
                                                      color: Color(int.parse(item.data.colorImages[position].color)),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () => provider.changeImagesGroup(item.data.colorImages[position].images, position),
                                              );
                                            },
                                            itemCount: item.data.colorImages.length,
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 20),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'تفاصيل المنتج',
                                          style: TextStyle(
                                            color: Color(0xff444343),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      wUtils.text(item.data.description),
                                      SizedBox(height: 36),

                                      ///sold items
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 6),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Text('منتجات مباعة ',
                                                style: TextStyle(color: Color(0xff444343), fontSize: 14, fontFamily: 'cairob')),
                                            Spacer(),
                                            Text('عرض الكل >       ',
                                                style: TextStyle(color: Colors.blue, fontSize: 14, fontFamily: 'cairob'))
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      FutureBuilder(
                                          future: iRepository.getSoldItems(),
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
                                                    return Container(
                                                      height: mUtils.height(context, 170),
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, position) => iItems.sold(context, soldItems.data[position]),
                                                        itemCount: soldItems.data.length,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Center(child: wUtils.text('حدث خطأ ما.'));
                                                }
                                                break;
                                            }
                                            return Center(child: CircularProgressIndicator());
                                          }),
                                      SizedBox(height: 10),

                                      ///same items
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 6),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Text('يوجد أيضاً ',
                                                style: TextStyle(color: Color(0xff444343), fontSize: 14, fontFamily: 'cairob')),
                                            Spacer(),
                                            InkWell(
                                              child: Text(
                                                'عرض الكل >       ',
                                                style: TextStyle(color: Colors.blue, fontSize: 14, fontFamily: 'cairob'),
                                              ),
                                               onTap: () => mUtils.navigatorWithBack(context, SubCategoriesPage(item.data.id))
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      FutureBuilder(
                                        future: siRepository.getSpecificItems(item.data.subcategoryId),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return Center(child: wUtils.text('nothing to show !'));
                                              break;
                                            case ConnectionState.waiting:
                                            case ConnectionState.active:
                                              return Center(child: CircularProgressIndicator());
                                              break;
                                            case ConnectionState.done:
                                              if (!snapshot.hasError) {
                                                if (snapshot.hasData) {
                                                  SI.SpecificItems sItem = snapshot.data;
                                                  return Container(
                                                    height: mUtils.height(context, 170),
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemBuilder: (context, position) => iItems.more(context, sItem.data[position]),
                                                      itemCount: sItem.data.length,
                                                    ),
                                                  );
                                                }
                                              } else {}
                                              break;
                                          }
                                          return Center(child: CircularProgressIndicator());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///footer
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Consumer<ItemProvider>(
                              builder: (context, provider, child) {
                                globalProvider = provider;
                                if (firstTime) {
                                  firstTime = false;
                                  globalProvider.changeLiked(gIsLiked);
                                }

                                return InkWell(
                                  child: Container(
                                    color: Colors.white,
                                    width: mUtils.width(context, 64),
                                    height: mUtils.height(context, 64),
                                    child: Icon(
                                      provider.isLiked ? Icons.star : Icons.star_border_outlined,
                                      color: cUtils.green,
                                    ),
                                  ),
                                  onTap: () {
                                    FavorateRequest favorateRequest = FavorateRequest(VariablesUtils.user.id.toString(), id.toString());
                                    fRepository.addFavorate(favorateRequest).then((value) {
                                      Provider.of<ItemProvider>(context, listen: false).changeLiked(!gIsLiked);
                                      gIsLiked = !gIsLiked;
                                    });
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: mUtils.height(context, 64),
                                  color: cUtils.primary,
                                  child: Center(
                                    child: Text(
                                      'إضافة إلى السلة',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Cart cart = Cart(VariablesUtils.user.id.toString(), id.toString(), '1', selectedColor, '0');
                                  iRepository.addToCart(cart).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(value.information),
                                      duration: Duration(seconds: 3),
                                    ));
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return Center(child: wUtils.text('nothing to show !'));
                  }
                } else {
                  return Center(child: wUtils.text('error occurred !'));
                }
                break;
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  slider(List<String> images) {
    CarouselController buttonCarouselController = CarouselController();

    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 1,
        aspectRatio: 1,
      ),
      items: images.map((i) {
        print(i);
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: mUtils.height(context, 237),
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: vUtils.baseItemsImageUrl + i,
                placeholder: (context, url) => Image.asset('assets/images/logo.png'),
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
