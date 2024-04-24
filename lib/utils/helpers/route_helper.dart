import 'package:flutter/material.dart';

class RouteHelper {
  static String? getCurrentRouteName(BuildContext context) {
    final currentRoute = ModalRoute.of(context);
    return currentRoute?.settings.name;
  }
}
