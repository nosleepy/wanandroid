import 'package:flutter/material.dart';
import 'package:wanandroid/ui/home_screen.dart';
import 'package:wanandroid/ui/square_screen.dart';
import 'package:wanandroid/ui/wechat_screen.dart';
import 'package:wanandroid/ui/system_screen.dart';
import 'package:wanandroid/ui/project_screen.dart';
import 'package:wanandroid/ui/share_acticle_screen.dart';
import 'package:wanandroid/ui/hot_word_screen.dart';
import 'package:wanandroid/ui/drawer_screen.dart';
import 'package:wanandroid/utils/toast_util.dart';

//首页
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  final bottomBarTitles = ["首页", "广场", "公众号", "体系", "项目"];
  var pages = [HomeScreen(), SquareScreen(), WeChatScreen(), SystemScreen(), ProjectScreen()];
  DateTime lastPressedAt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: DrawerScreen(),
        appBar: AppBar(
          title: Text(bottomBarTitles[_selectedIndex]),
          bottom: null,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                if (_selectedIndex == 1) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShareActicleScreen())); // 分享
                } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HotWordScreen())); // 搜索
                }
              },
              icon: _selectedIndex == 1 ? Icon(Icons.add) : Icon(Icons.search)),
          ],
        ),
        body: PageView.builder(
          itemBuilder: (context, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: buildImage(0, "ic_home"),
              label: bottomBarTitles[0],
            ),
            BottomNavigationBarItem(
              icon: buildImage(1, "ic_square_line"),
              label: bottomBarTitles[1],
            ),
            BottomNavigationBarItem(
              icon: buildImage(2, "ic_wechat"),
              label: bottomBarTitles[2],
            ),
            BottomNavigationBarItem(
              icon: buildImage(3, "ic_system"),
              label: bottomBarTitles[3],
            ),
            BottomNavigationBarItem(
              icon: buildImage(4, "ic_project"),
              label: bottomBarTitles[4],
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  Future<bool> _onWillPop() async {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text("提示"),
    //     content: const Text("确定退出应用吗？"),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(false),
    //         child: const Text("再看一会", style: TextStyle(color: Colors.cyan),)),
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(true),
    //         child: const Text("退出", style: TextStyle(color: Colors.cyan),)),
    //     ],
    //   ),
    // );
    // return false;
    if (DateTime.now().difference(lastPressedAt) > const Duration(seconds: 1)) {
      T.show("1秒内连续按两次返回键退出");
      lastPressedAt = DateTime.now();
      return false;
    }
    return true;
  }

  Widget buildImage(index, iconPath) {
    return Image.asset(
      "assets/images/$iconPath.png",
      width: 22,
      height: 22,
      color: _selectedIndex == index ? Theme.of(context).primaryColor : Colors.grey[600],
    );
  }
}