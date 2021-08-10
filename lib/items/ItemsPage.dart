import 'package:alshakireen/item/ItemPage.dart';
import 'package:alshakireen/items/SpeceficItemsRepository.dart';
import 'package:alshakireen/items/addItem/AddItemPage.dart';
import 'package:alshakireen/items/models/SpecificItems.dart';
import 'package:alshakireen/subCategories/SubCategories.dart' as SC;
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemsPage extends StatefulWidget {
  SC.Datum data;

  ItemsPage(this.data);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return ItemsScreen(widget.data);
  }
}

class ItemsScreen extends StatefulWidget {
  SC.Datum data;

  ItemsScreen(this.data);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, widget.data.name),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:FutureBuilder(
          future: siRepository.getSpecificItems(widget.data.id),
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
                    SpecificItems specificItems = snapshot.data;
                    return GridView.count(
                      padding: const EdgeInsets.all(15),
                      shrinkWrap: true,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      primary: false,
                      children: List.generate(specificItems.data.length, (position) {
                        return InkWell(
                          child: Container(
                            height: mUtils.height(context, 200),
                            width: mUtils.width(context, 180),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: CachedNetworkImage(
                                    imageUrl: vUtils.baseItemsImageUrl + specificItems.data[position].image,
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
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        specificItems.data[position].name,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: cUtils.green, fontSize: 14, fontFamily: 'cairob'),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                        height: mUtils.height(context, 18),
                                        width: mUtils.width(context, 40),
                                        color: Color(0xffEEEEEE),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'ألوان: '+specificItems.data[position].colors.toString(),
                                          style: TextStyle(
                                            color: cUtils.green,
                                            fontSize: 10,
                                            fontFamily: 'cairob',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${specificItems.data[position].price} JOD',
                                            style: TextStyle(color: cUtils.primary, fontSize: 14, fontFamily: 'cairob'),
                                          ),
                                          Icon(Icons.add, color: cUtils.green),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                VariablesUtils.isAdmin
                                    ?InkWell(
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
                                  onTap: () => siRepository.deleteItem(specificItems.data[position].id).then((value) {
                                    if (value.success)
                                      setState(() {});
                                    else {
                                      print('error occurred');
                                    }
                                  }),
                                ): Container(),
                              ],
                            ),
                          ),
                          onTap: () => mUtils.navigatorWithBack(context, ItemPage(specificItems.data[position].id)),
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
          }),),
      floatingActionButton: VariablesUtils.isAdmin
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 64),
              child: InkWell(
                child: FloatingActionButton(
                  backgroundColor: cUtils.primary,
                  child: Icon(Icons.add, size: 30),
                ),
                onTap: () => mUtils.navigatorWithBack(context, AddItemPage(widget.data.id)),
              ))
          : Container(),
    );
  }
}
