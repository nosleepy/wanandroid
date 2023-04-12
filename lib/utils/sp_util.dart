import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  SPUtil._internal();
  static final SPUtil singleton = SPUtil._internal();
  factory SPUtil() {
    return singleton;
  }
}