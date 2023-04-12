import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/user_manager.dart';
import 'package:wanandroid/data/api/apis_service.dart';
import 'package:wanandroid/model/base_model.dart';
import 'package:wanandroid/model/project_article_model.dart';
import 'package:wanandroid/model/project_tree_model.dart';
import 'package:wanandroid/ui/progress_screen.dart';
import 'package:wanandroid/widgets/item_project_list.dart';
import 'package:wanandroid/utils/toast_util.dart';

class ProjectScreen extends StatefulWidget {
  @override
  State<ProjectScreen> createState() => ProjectScreenState();
}

class ProjectScreenState extends State<ProjectScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<ProjectTreeBean> projectTreeList = [];
  late TabController tabController;
  bool isLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getProjectTreeList();
    tabController = TabController(length: 28, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad ? ProgressScreen() :  Column(
        children: [
          Container(
            height: 50,
            color: Theme.of(context).primaryColor,
            child: Offstage(
              offstage: projectTreeList.isEmpty,
              child: TabBar(
                indicatorColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 16),
                unselectedLabelStyle: const TextStyle(fontSize: 16),
                controller: tabController,
                isScrollable: true,
                tabs: projectTreeList.map((ProjectTreeBean item) => Tab(text: item.name,)).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: projectTreeList.map((ProjectTreeBean item) => ProjectArticleScreen(item.id)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future getProjectTreeList() async {
    ApiService().getProjectTreeList((Response response) {
      ProjectTreeModel projectTreeModel = projectTreeModelFromJson(response.toString());
      setState(() {
        projectTreeList = projectTreeModel.data;
        isLoad = false;
      });
    });
  }
}

class ProjectArticleScreen extends StatefulWidget {
  int id;

  ProjectArticleScreen(this.id);

  @override
  State<ProjectArticleScreen> createState() {
    return ProjectArticleScreenState();
  }
}

class ProjectArticleScreenState extends State<ProjectArticleScreen> with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  List<ProjectArticleBean> projectArticleList = [];
  int page = 1;
  bool showFab = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getProjectArticleList();
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
        getProjectArticleList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: itemView,
        itemCount: projectArticleList.length,
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
    ProjectArticleBean projectArticleBean = projectArticleList[index];
    return ItemProjectList(projectArticleBean, () {
      addOrCancelCollect(projectArticleBean);
    });
  }

  void addOrCancelCollect(ProjectArticleBean item) {
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

  Future getProjectArticleList() async {
    ApiService().getProjectArticleList((Response response) {
      ProjectArticleModel projectArticleModel = projectArticleModelFromJson(response.toString());
      setState(() {
        projectArticleList.addAll(projectArticleModel.data.datas);
      });
    }, widget.id, page++);
  }
}