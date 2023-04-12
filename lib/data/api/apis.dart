class Apis {
  static const String BASE_HOST = "https://www.wanandroid.com";
  static const String USER_LOGIN = BASE_HOST + "/user/login";
  static const String USER_LOGOUT = BASE_HOST + "/user/logout/json";
  static const String USER_INFO = BASE_HOST + "/lg/coin/userinfo/json";
  static const String HOME_BANNER = BASE_HOST + "/banner/json";
  static const String HOME_TOP_ARTICLE_LIST = BASE_HOST + "/article/top/json";
  static const String HOME_ARTICLE_LIST = BASE_HOST + "/article/list";
  static const String SQUARE_LIST = BASE_HOST + "/user_article/list"; // 广场列表
  static const String WX_CHAPTERS_LIST = BASE_HOST + "/wxarticle/chapters/json"; // 公众号名称
  static const String WX_ARTICLE_LIST = BASE_HOST + "/wxarticle/list"; // 公众号文章数据
  static const String PROJECT_TREE_LIST = BASE_HOST + "/project/tree/json"; // 项目分类列表
  static const String PROJECT_ARTICLE_LIST = BASE_HOST + "/project/list"; // 项目文章列表数据
  static const String COLLECTION_LIST = BASE_HOST + "/lg/collect/list"; // 收藏文章列表
  static const String CANCEL_COLLECTION = BASE_HOST + "/lg/uncollect_originId"; // 取消收藏
  static const String ADD_COLLECTION = BASE_HOST + "/lg/collect"; // 新增收藏
}