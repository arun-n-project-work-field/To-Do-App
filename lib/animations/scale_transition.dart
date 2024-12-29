import 'package:flutter/material.dart';

class ScaleTransitionPageRoute extends PageRouteBuilder {
  final Widget child;

  ScaleTransitionPageRoute({required this.child})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInOut;
      var scaleAnimation = Tween(begin: begin, end: end).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      ));

      return ScaleTransition(
        scale: scaleAnimation,
        child: child,
      );
    },
  );
}