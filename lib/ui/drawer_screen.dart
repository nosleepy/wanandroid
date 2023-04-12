import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/base_model.dart';
import 'package:wanandroid/model/user_info_model.dart';
import 'package:wanandroid/model/user_model.dart';
import 'package:wanandroid/res/styles.dart';
import 'package:wanandroid/ui/collect_screen.dart';
import 'package:wanandroid/ui/login_screen.dart';
import 'package:wanandroid/utils/event_bus_util.dart';
import 'package:wanandroid/utils/route_util.dart';
import 'package:wanandroid/utils/toast_util.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<DrawerScreen> createState() => DrawerScreenState();
}

class DrawerScreenState extends State<DrawerScreen> with AutomaticKeepAliveClientMixin {
  bool isLogin = false;
  String username = "去登录";
  String level = "--";
  String rank = "--";
  String myScore = "";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    registerLoginEvent();
    if (UserManager().userName.isNotEmpty) {
      isLogin = true;
      username = UserManager().userName;
      getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 40, 16, 10),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Image.asset(
                      "assets/images/ic_rank.png",
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    onTap: () {

                    },
                  ),
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/ic_default_avatar.png"),
                  radius: 40.0,
                ),
                Gaps.vGap10,
                InkWell(
                  onTap: () {
                    if (!isLogin) {
                      RouteUtil.push(context, LoginScreen());
                    }
                  },
                  child: Text(
                    username,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Gaps.vGap5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "等级:",
                      style: TextStyle(fontSize: 11, color: Colors.grey[100]),
                    ),
                    Text(
                      level,
                      style: TextStyle(fontSize: 11, color: Colors.grey[100]),
                    ),
                    Gaps.hGap5,
                    Text(
                      "排名:",
                      style: TextStyle(fontSize: 11, color: Colors.grey[100]),
                    ),
                    Text(
                      rank,
                      style: TextStyle(fontSize: 11, color: Colors.grey[100]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              "我的积分",
              style: TextStyle(fontSize: 16),
            ),
            leading: Image.asset(
              "assets/images/ic_score.png",
              width: 24,
              height: 24,
              color: Theme.of(context).primaryColor,
            ),
            trailing: Text(myScore, style: TextStyle(color: Colors.grey[500]),),
            onTap: () {
              if (isLogin) {

              } else {
                T.show("请先登录~");
                RouteUtil.push(context, LoginScreen());
              }
            },
          ),
          ListTile(
            title: const Text(
              "我的收藏",
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(
              Icons.favorite_border,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (isLogin) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return CollectScreen();
                }));
              } else {
                T.show("请先登录~");
                RouteUtil.push(context, LoginScreen());
              }
            },
          ),
          ListTile(
            title: const Text(
              "我的分享",
              style: TextStyle(fontSize: 16),
            ),
            leading: Image.asset(
              "assets/images/ic_share.png",
              width: 24,
              height: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (isLogin) {

              } else {
                T.show("请先登录~");
                // RouteUtil.push(context, LoginScreen());
              }
            },
          ),
          ListTile(
            title: const Text(
              "TODO",
              style: TextStyle(fontSize: 16),
            ),
            leading: Image.asset(
              "assets/images/ic_todo.png",
              width: 24,
              height: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              if (isLogin) {

              } else {
                T.show("请先登录~");
                // RouteUtil.push(context, LoginScreen());
              }
            },
          ),
          ListTile(
            title: const Text(
              "夜间模式",
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(
              Icons.brightness_2,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              setState(() {

              });
            },
          ),
          ListTile(
            title: const Text(
              "系统设置",
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(
              Icons.settings,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {

            },
          ),
          Offstage(
            offstage: !isLogin,
            child: ListTile(
              title: const Text(
                "退出登录",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(
                Icons.power_settings_new,
                size: 24,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                _logout(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text("确定退出登录吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("取消",)),
          TextButton(
            onPressed: () {
              ApiService().logout((Response response) {
                Navigator.of(context).pop(true);
                BaseModel baseModel = baseModelFromJson(response.toString());
                print('wlzhou, response = aaaa = ${baseModel.toJson()}');
                if (baseModel.errorCode == 0) {
                  UserManager().clearUserInfo();
                  setState(() {
                    isLogin = false;
                    username = "去登录";
                    level = "--";
                    rank = "--";
                    myScore = "";
                  });
                }
              });
            },
            child: Text("确定"),)
        ],
      ),
    );
  }

  void registerLoginEvent() {
    eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        isLogin = true;
        username = UserManager().userName;
        getUserInfo();
      });
    });
  }

  Future getUserInfo() async {
    ApiService().getUserInfo((Response response) {
      UserInfoModel userInfoModel = userInfoModelFromJson(response.toString());
      print("wlzhou, userInfoModel = ${userInfoModel.toJson()}");
      if (userInfoModel.errorCode == 0) {
        setState(() {
          level = userInfoModel.data.level.toString();
          rank = userInfoModel.data.rank;
          myScore = userInfoModel.data.coinCount.toString();
        });
      }
    });
  }

  // void printCookieInfo(Response response) async {
  //   List<Cookie> list = await ApiService.cookieJar.loadForRequest(response.realUri);
  //   for (Cookie cookie in list) {
  //     print("wlzhou, c = $cookie");
  //   }
  // }
}