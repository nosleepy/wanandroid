import 'package:dio/dio.dart';
import 'package:wanandroid/data/api/apis.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiService {
  static final CookieJar cookieJar = CookieJar();
  static final Dio dio = Dio();

  ApiService._internal();
  static final ApiService singleton = ApiService._internal();
  factory ApiService() {
    dio.interceptors.add(CookieManager(cookieJar));
    return singleton;
  }

  // 登录
  void login(Function callback, String _username, String _password) async {
    FormData formData = FormData.fromMap({"username": _username, "password": _password});
    await dio.post(Apis.USER_LOGIN, data: formData).then((response) {
      callback(response);
    });
  }

  // 退出
  void logout(Function callback) async {
    dio.get(Apis.USER_LOGOUT).then((response) {
      callback(response);
    });
  }

  // 获取用户个人信息
  void getUserInfo(Function callback) async {
    await dio.get(Apis.USER_INFO).then((response) {
      callback(response);
    });
  }

  // 首页轮播图
  void getBannerList(Function callback) async {
    await dio.get(Apis.HOME_BANNER).then((response) => callback(response));
  }

  // 获取置顶文章列表
  void getTopArticleList(Function callback) async {
    await dio.get(Apis.HOME_TOP_ARTICLE_LIST).then((response) => callback(response));
  }

  // 获取首页文章列表
  void getArticleList(Function callback, int page) async {
    await dio.get("${Apis.HOME_ARTICLE_LIST}/$page/json").then((response) => callback(response));
  }

  // 获取广场文章列表
  void getSquareList(Function callback, int page) async {
    await dio.get("${Apis.SQUARE_LIST}/$page/json").then((response) => callback(response));
  }

  // 获取公众号列表
  void getWxChaptersList(Function callback) async {
    await dio.get(Apis.WX_CHAPTERS_LIST).then((response) => callback(response));
  }

  // 获取公众号历史数据
  void getWxArticleList(Function callback, int id, int page) async {
    await dio.get("${Apis.WX_ARTICLE_LIST}/$id/$page/json").then((response) => callback(response));
  }

  // 获取项目分类列表数据
  void getProjectTreeList(Function callback) async {
    await dio.get(Apis.PROJECT_TREE_LIST).then((response) => callback(response));
  }

  // 获取项目文章列表数据
  void getProjectArticleList(Function callback, int cid, int page) async {
    await dio.get("${Apis.PROJECT_ARTICLE_LIST}/$page/json?cid=$cid").then((response) => callback(response));
  }

  // 获取收藏文章列表
  void getCollectionList(Function callback, int page) async {
    await dio.get("${Apis.COLLECTION_LIST}/$page/json").then((response) => callback(response));
  }

  // 取消收藏
  void cancelCollection(Function callback, int id) async {
    await dio.post("${Apis.CANCEL_COLLECTION}/$id/json").then((response) => callback(response));
  }

  // 新增收藏
  void addCollection(Function callback, int id) async {
    await dio.post("${Apis.ADD_COLLECTION}/$id/json").then((response) => callback(response));
  }
}