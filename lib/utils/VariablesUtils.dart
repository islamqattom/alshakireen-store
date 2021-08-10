import 'package:alshakireen/login/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VariablesUtils {
  final baseUrl = 'http://192.168.1.13:8080/api/';
  final baseImageUrl = 'http://192.168.1.13:8080/storage/images/';
  final baseCatsImageUrl = 'http://192.168.1.13:8080/storage/images/categories/';
  final baseSubCatsImageUrl = 'http://192.168.1.13:8080/storage/images/subCategories/';
  final baseItemsImageUrl = 'http://192.168.1.13:8080/storage/images/items/';
  final baseSliderImageUrl = 'http://192.168.1.13:8080/storage/images/slider/';

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static Information user;
  static bool isAdmin = false;
}

VariablesUtils vUtils = VariablesUtils();
