import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Toast 简单封装
class T {
  static show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[100],
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}