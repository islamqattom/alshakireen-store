import 'package:alshakireen/adminPanel/itemUsers/ItemUsers.dart';
import 'package:alshakireen/adminPanel/itemUsers/ItemUsersRepository.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';


class SoldItemUsersPage extends StatefulWidget {
  int iId;

  SoldItemUsersPage(this.iId);

  @override
  _SoldItemUsersPageState createState() => _SoldItemUsersPageState();
}

class _SoldItemUsersPageState extends State<SoldItemUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'المستخدمين'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: iURepository.getitemUsers(widget.iId),
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
                      ItemUsers itemUsers = snapshot.data;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, position) {
                          return Column(children:
                          [Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: cUtils.green,
                                width: 2,

                              ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            height: mUtils.height(context, 70),
                            // color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(width: mUtils.width(context, 20)),
                                CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    color: cUtils.primary,
                                  ),
                                  radius: mUtils.width(context, 20),
                                  backgroundColor: Color(0x33feae01),
                                ),
                                SizedBox(width: mUtils.width(context, 10)),
                                Text(
                                  itemUsers.data[position].userName,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: cUtils.green,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: mUtils.width(context, 70)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Row(children: [
                                      Text(
                                        'العدد: ' ,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: cUtils.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        itemUsers.data[position].quantity.toString(),
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: cUtils.primary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ]);
                        },
                        itemCount: itemUsers.data.length,
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
    );
  }
}
