import 'package:flutter/material.dart';

PageRouteBuilder SwipeUpPageRouteBuilder(Widget route) {
  return PageRouteBuilder(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    pageBuilder: (context, anmation, secondaryAnimation) => route,
    fullscreenDialog: true,
  );
}
