import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteUtil {
  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}