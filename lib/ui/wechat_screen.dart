import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/base_model.dart';
import 'package:wanandroid/model/wx_article_model.dart';
import 'package:wanandroid/model/wx_chapters_model.dart';
import 'package:wanandroid/ui/progress_screen.dart';
import 'package:wanandroid/widgets/item_wechat_list.dart';
import 'package:wanandroid/utils/toast_util.dart';

class WeChatScreen extends StatefulWidget {
  @override
  State<WeChatScreen> createState() => WeChatScreenState();
}

class WeChatScreenState extends State<WeChatScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<WxChaptersBean> chaptersList = [];
  late TabController tabController;
  bool isLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getWxChaptersList();
    tabController = TabController(length: 14, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad ? ProgressScreen() : Column(
        children: [
          Container(
            height: 50,
            color: Theme.of(context).primaryColor,
            child: Offstage(
              offstage: chaptersList.isEmpty,
              child: TabBar(
                indicatorColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 16),
                unselectedLabelStyle: const TextStyle(fontSize: 16),
                controller: tabController,
                isScrollable: true,
                tabs: chaptersList.map((WxChaptersBean item) => Tab(text: item.name,)).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: chaptersList.map((WxChaptersBean item) => WxArticleScreen(item.id)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future getWxChaptersList() async {
    ApiService().getWxChaptersList((Response response) {
      WxChaptersModel wxChaptersModel = wxChaptersModelFromJson(response.toString());
      // print("wlzhou, wxChaptersModel = ${wxChaptersModel.toJson()}");
      setState(() {
        chaptersList = wxChaptersModel.data;
        isLoad = false;
      });
    });
  }
}

class WxArticleScreen extends StatefulWidget {
  int id;

  WxArticleScreen(this.id);

  @override
  State<WxArticleScreen> createState() {
    return WxArticleScreenState();
  }
}

class WxArticleScreenState extends State<WxArticleScreen> with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  List<WxArticleBean> wxArticleList = [];
  int page = 1;
  bool showFab = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getWxArticleList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(() {
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
        getWxArticleList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: itemView,
        itemCount: wxArticleList.length,
        controller: scrollController,
      ),
      floatingActionButton: !showFab ? null : FloatingActionButton(
        heroTag: "home",
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          scrollController.animateTo(0, duration: const Duration(milliseconds: 2000), curve: Curves.ease);
        },
      ),
    );
  }

  Widget itemView(BuildContext context, int index) {
    WxArticleBean wxArticleBean = wxArticleList[index];
    return ItemWeChatList(wxArticleBean, () {
      addOrCancelCollect(wxArticleBean);
    });
  }

  void addOrCancelCollect(WxArticleBean item) {
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

  Future getWxArticleList() async {
    ApiService().getWxArticleList((Response response) {
      WxArticleModel wxArticleModel = wxArticleModelFromJson(response.toString());
      setState(() {
        wxArticleList.addAll(wxArticleModel.data.datas);
      });
    }, widget.id, page++);
  }
}