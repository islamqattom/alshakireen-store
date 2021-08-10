import 'dart:developer';
import 'package:alshakireen/adminPanel/user/User.dart';
import 'package:alshakireen/adminPanel/user/UserItems.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<Users> getUsers() async {
    String url = '${vUtils.baseUrl}getUsers';

    var response = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    log(response.request.toString());
    log(response.body.toString());

    Users users = Users(success: false, information: 'error', data: null);
    if (response.statusCode == 200) {
      users = usersFromJson(response.body);
    }
    return users;
  }

  Future<UserItems> getUserItems(int userId) async {
    String url = '${vUtils.baseUrl}getUserItems/$userId';

    var response = await http.get(Uri.parse(url));

    log(response.body);
    log(response.request.toString());

    UserItems userItems = UserItems(success: false, information: 'error occurred', data: null);
    if (response.statusCode == 200) {
      userItems = userItemsFromJson(response.body);
    }

    return userItems;
  }
}


UserRepository uRepository=UserRepository();