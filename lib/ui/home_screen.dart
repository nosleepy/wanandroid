import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/article_bean.dart';
import 'package:wanandroid/model/article_model.dart';
import 'package:wanandroid/model/banner_model.dart';
import 'package:wanandroid/model/base_model.dart';
import 'package:wanandroid/model/top_article_model.dart';
import 'package:wanandroid/ui/progress_screen.dart';
import 'package:wanandroid/utils/event_bus_util.dart';
import 'package:wanandroid/widgets/item_article_list.dart';
import 'package:wanandroid/utils/toast_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin  {
  List<BannerBean> bannerList = [];
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
    registerLoginEvent();
    getBannerList();
    getTopArticleList();
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
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad ? ProgressScreen() :  ListView.builder(
        itemBuilder: _itemView,
        itemCount: articleList.length + 1,
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

  Widget _itemView(BuildContext context, int index) {
    // print("wlzhou, index = $index");
    if (index == 0) {
      return Container(
        height: 200,
        child: _buildBannerWidget(),
      );
    }
    if (index == articleList.length) {
      // T.show("加载更多");
      // getArticleList(page++);
    }
    ArticleBean item = articleList[index - 1];
    return ItemArticleList(item, index <= 4 ? true : false, () {
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

  Widget _buildBannerWidget() {
    return Offstage(
      offstage: bannerList.isEmpty,
      child: Swiper(
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        itemCount: bannerList.length,
        autoplay: true,
        pagination: const SwiperPagination(),
      ),
    );
  }

  Future getBannerList() async {
    ApiService().getBannerList((Response response) {
      BannerModel bannerModel = bannerModelFromJson(response.toString());
      // print("wlzhou, bannerList size = ${bannerList.length}");
      setState(() {
        bannerList = bannerModel.data;
        isLoad = false;
      });
    });
  }

  Future getTopArticleList() async {
    ApiService().getTopArticleList((Response response) {
      TopArticleModel topArticleModel = topArticleModelFromJson(response.toString());
      // print("wlzhou, ---------------------articleList size = ${articleList.length}");
      print("wlzhou, ---------------------articleList ffff = ${topArticleModel.toJson()}");
      setState(() {
        articleList.addAll(topArticleModel.data);
      });
    });
  }

  Future getArticleList(int page) async {
    // print("wlzhou, page =------------------------= $page");
    ApiService().getArticleList((Response response) {
      ArticleModel articleModel = articleModelFromJson(response.toString());
      print("wlzhou, articleModel = ${articleModel.toJson()}");
      setState(() {
        articleList.addAll(articleModel.data.datas);
      });
    }, page);
  }

  void registerLoginEvent() {
    eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        page = 0;
        articleList.clear();
        getTopArticleList();
        getArticleList(page++);
      });
    });
  }
}