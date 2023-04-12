import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/user_model.dart';
import 'package:wanandroid/res/styles.dart';
import 'package:wanandroid/utils/event_bus_util.dart';
import 'package:wanandroid/utils/toast_util.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _psdController = TextEditingController();
  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _psdFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Gaps.vGap20,
              Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "用户登录",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "请使用WanAndroid账号登录",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: TextField(
                  focusNode: _userNameFocusNode,
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                  ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: TextField(
                  focusNode: _psdFocusNode,
                  controller: _psdController,
                  decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                  ),
                  obscureText: true,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 28),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          String username = _userNameController.text;
                          String password = _psdController.text;
                          _login(username, password);
                        },
                        child: const Text("登录"),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {

                  },
                  child: const Text("还没有账号，注册一个？", style: TextStyle(fontSize: 14),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(String username, String password) {
    username = username.trim();
    password = password.trim();
    if (username.isNotEmpty && password.isNotEmpty) {
      ApiService().login((Response response) {
        print('wlzhou,login = ${response.toString()}');
        UserModel userModel = userModelFromJson(response.toString());
        if (userModel.errorCode == 0) {
          UserManager().saveUserInfo(userModel, response);
          eventBus.fire(LoginEvent());
          T.show("登录成功");
          Navigator.of(context).pop();
        } else {
          T.show("账号密码不匹配！");
        }
      }, username, password);
    } else {
      T.show("用户名或密码不能为空");
    }
  }
}