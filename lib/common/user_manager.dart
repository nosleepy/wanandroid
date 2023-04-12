import 'package:wanandroid/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class UserManager {
  UserManager._internal();
  static final UserManager singleton = UserManager._internal();
  factory UserManager() => singleton;

  List<String> cookie = [];
  String userName = "";

  void saveUserInfo(UserModel userModel, Response response) {
    List<String> cookies = response.headers["set-cookie"] as List<String>;
    cookie = cookies;
    userName = userModel.data.username;
    saveInfo();
  }

  void saveInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("cookies_key", cookie);
    prefs.setString("username_key", userName);
  }

  void clearUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("cookies_key");
    prefs.remove("username_key");
  }
}