import 'package:alshakireen/adminPanel/user/User.dart';
import 'package:alshakireen/adminPanel/user/UserItemsPage.dart';
import 'package:alshakireen/adminPanel/user/UserRepository.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wUtils.appBar(context, 'المستخدمين'),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: uRepository.getUsers(),
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
                    Users users = snapshot.data;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        return InkWell(
                          child: Container(
                            height: mUtils.height(context, 70),
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(width: mUtils.width(context, 10)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    SizedBox(height: mUtils.height(context, 10)),
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
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
                                          users.data[position].name,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: Color(0xff444343),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: mUtils.height(context, 12)),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(Icons.arrow_back_ios, color: cUtils.green),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => mUtils.navigatorWithBack(context, UserItemsPage(users.data[position].id)),
                        );
                      },
                      itemCount: users.data.length,
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
    );
  }
}
