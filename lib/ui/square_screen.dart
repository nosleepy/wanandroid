import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/article_bean.dart';
import 'package:wanandroid/model/article_model.dart';
import 'package:wanandroid/model/base_model.dart';
import 'package:wanandroid/widgets/item_article_list.dart';
import 'package:wanandroid/utils/toast_util.dart';
import 'package:wanandroid/ui/progress_screen.dart';

class SquareScreen extends StatefulWidget {
  @override
  State<SquareScreen> createState() => SquareScreenState();
}

class SquareScreenState extends State<SquareScreen> with AutomaticKeepAliveClientMixin {
  List<ArticleBean> articleList = [];
  ScrollController scrollController = ScrollController();
  int page = 0;
  bool showFab = false;
  bool isLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getArticleList(page++);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(() {
      // print("wlzhou, offset = ${scrollController.offset}");
      if (scrollController.offset >= 200) {
        setState(() {
          showFab = true;
        });
      } else {
        setState(() {
          showFab = false;
        });
      }
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        T.show("加载更多");
        getArticleList(page++);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: isLoad ? ProgressScreen() : ListView.builder(
          itemBuilder: _itemView,
          itemCount: articleList.length,
          controller: scrollController,
        ),
        floatingActionButton: !showFab ? null : FloatingActionButton(
          heroTag: "home",
          child: const Icon(Icons.arrow_upward),
          onPressed: () {
            scrollController.animateTo(0, duration: const Duration(milliseconds: 2000), curve: Curves.ease);
          },
        ),
      ),
    );
  }

  Widget _itemView(BuildContext context, int index) {
    ArticleBean item = articleList[index];
    return ItemArticleList(item, false, () {
      addOrCancelCollect(item);
    });
  }

  void addOrCancelCollect(ArticleBean item) {
    List<String> cookies = UserManager().cookie;
    if (cookies.isEmpty) {
      T.show("请先登录");
    } else {
      if (item.collect) {
        ApiService().cancelCollection((Response response) {
          // print('wlzhou, cancelCollection = ${response.toString()}');
          BaseModel baseModel = baseModelFromJson(response.toString());
          if (baseModel.errorCode == 0) {
            T.show("已取消收藏");
            setState(() {
              item.collect = false;
            });
          }
        }, item.id);
      } else {
        ApiService().addCollection((Response response) {
          // print('wlzhou, addCollection = ${response.toString()}');
          BaseModel baseModel = baseModelFromJson(response.toString());
          if (baseModel.errorCode == 0) {
            T.show("收藏成功");
            setState(() {
              item.collect = true;
            });
          }
        }, item.id);
      }
    }
  }

  Future getArticleList(int page) async {
    ApiService().getSquareList((Response response) {
      ArticleModel articleModel = articleModelFromJson(response.toString());
      // print("wlzhou, articleModel111 = ${articleModel.toJson()}");
      setState(() {
        articleList.addAll(articleModel.data.datas);
        isLoad = false;
      });
    }, page);
  }
}