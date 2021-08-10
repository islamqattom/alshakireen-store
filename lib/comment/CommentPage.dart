import 'package:alshakireen/comment/Comment.dart';
import 'package:alshakireen/comment/CommentRepository.dart';
import 'package:alshakireen/comment/CommentRequest.dart';
import 'package:alshakireen/utils/MethodsUtils.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/WidgetsUtils.dart';
import 'package:alshakireen/utils/colors/ColorsUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentPage extends StatefulWidget {
  int iId;

  CommentPage(this.iId);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController comment = TextEditingController();
  TextEditingController userId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: wUtils.appBar(context, 'التعليقات'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder(
              future: cMRepository.getComment(widget.iId),
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
                        Comment comments = snapshot.data;
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, position) {
                            return Wrap(children: <Widget>[
                              Container(
                                  // color: Color(0xffF6F6F6),
                                  // height: mUtils.height(context, 80),
                                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: mUtils.width(context, 15),
                                        ),
                                        SizedBox(height: mUtils.height(context, 10)),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(
                                                    Icons.person,
                                                    color: cUtils.primary,
                                                  ),
                                                  radius: mUtils.width(context, 20),
                                                  backgroundColor: Color(0x33feae01),
                                                ),
                                                SizedBox(
                                                  width: mUtils.width(context, 10),
                                                ),
                                                Column(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      comments.data[position].userName,
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: cUtils.green,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      comments.data[position].createdAt.toString(),
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: cUtils.green,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),

                                          ],
                                        ),
                                        Spacer(),
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
                                          onTap: () => cMRepository.deleteComment(comments.data[position].id).then((value) {
                                            if (value.success)
                                              setState(() {});
                                            else {
                                              print('error occurred');
                                            }
                                          }),
                                        ): Container(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: mUtils.width(context, 65)),
                                        Text(
                                          comments.data[position].comment,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: cUtils.green,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    )
                                  ]))
                            ]);
                          },
                          itemCount: comments.data.length,
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
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: comment,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintStyle: TextStyle(), hintText: 'أدخل تعليق'),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
              ),
            ),
            SizedBox(height: mUtils.height(context, 10)),
            InkWell(
                child: Container(
                    margin: const EdgeInsets.only(left: 83, right: 83),
                    color: cUtils.green,
                    height: mUtils.height(context, 39),
                    width: mUtils.width(context, 60),
                    child: Center(child: Text("إضافة", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'cairob')))),
                onTap: () {
                  cMRepository
                      .addComment(CommentRequest(
                    comment.text.toString(),
                    VariablesUtils.user.id.toString(),
                    widget.iId.toString(),
                  ))
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value.information),
                      duration: Duration(seconds: 3),
                    ));
                  });
                })
          ]),
        ),
      ),
    );
  }
}
