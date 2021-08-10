import 'dart:convert';
import 'dart:developer';
import 'package:alshakireen/comment/Comment.dart';
import 'package:alshakireen/comment/CommentRequest.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Future<GeneralResponse> addComment(CommentRequest commentRequest) async {
    String url = '${vUtils.baseUrl}addComment';

    var response = await http.post(Uri.parse(url), body:jsonEncode(commentRequest) ,headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",

    });
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }


  Future<Comment> getComment(int itemId) async {
    String url = '${vUtils.baseUrl}getComment/$itemId';

    var response = await http.get(Uri.parse(url),headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    log(response.body.toString());

    Comment comment = Comment();
    if (response.statusCode == 200) {
      comment = commentFromJson(response.body);
    }
    return comment;
  }

  Future<GeneralResponse> deleteComment(int id) async {
    String url = '${vUtils.baseUrl}deleteComment/$id';

    var response = await http.post(Uri.parse(url), headers: {"Accept": "application/json"});

    log(response.body.toString());

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error');
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      generalResponse = GeneralResponse(success: jsonData['success'], information: jsonData['information']);
    }
    return generalResponse;
  }
}

CommentRepository cMRepository=CommentRepository();