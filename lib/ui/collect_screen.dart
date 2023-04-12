import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/article_bean.dart';
import 'package:wanandroid/model/base_model.dart';
import 'package:wanandroid/model/collection_model.dart';
import 'package:wanandroid/widgets/item_collect_list.dart';
import 'package:wanandroid/utils/toast_util.dart';

class CollectScreen extends StatefulWidget {
  @override
  State<CollectScreen> createState() {
    return CollectScreenState();
  }
}

class CollectScreenState extends State<CollectScreen> {
  ScrollController scrollController = ScrollController();
  List<CollectionBean> collectList = [];
  int page = 0;
  bool showFab = false;

  @override
  void initState() {
    super.initState();
    getCollectionList();
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
        getCollectionList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("收藏"),
      ),
      body: ListView.builder(
        itemBuilder: itemView,
        itemCount: collectList.length,
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
    CollectionBean collectionBean = collectList[index];
    return ItemCollectList(collectionBean, () {
      cancelCollect(collectionBean);
    });
  }

  void cancelCollect(CollectionBean item) {
    ApiService().cancelCollection((Response response) {
      BaseModel baseModel = baseModelFromJson(response.toString());
      if (baseModel.errorCode == 0) {
        T.show("已取消收藏");
        setState(() {
          collectList.clear();
          page = 0;
          getCollectionList();
        });
      } else {
        T.show("取消失败");
      }
    }, item.originId);
  }

  Future getCollectionList() async {
    ApiService().getCollectionList((Response response) {
      CollectionModel collectionModel = collectionModelFromJson(response.toString());
      setState(() {
        collectList.addAll(collectionModel.data.datas);
      });
    }, page++);
  }
}