import 'package:flutter/material.dart';

class Responsive {
  double minWidth;
  List items;
  List breakpoints = [
    480,
    768,
    1024,
    1200
  ]; // mobile, tablet, notebook, desktop

  Responsive({required this.minWidth, this.items = const []});

  bool isMobile() {
    return (minWidth <= breakpoints[1]);
  }

  bool isTablet() {
    return (minWidth > breakpoints[1] && minWidth <= breakpoints[2]);
  }

  bool isNotebook() {
    return (minWidth > breakpoints[2] && minWidth <= breakpoints[3]);
  }

  bool isDesktop() {
    return (minWidth > breakpoints[3]);
  }

  TextStyle getCorrectText() {
    if (isDesktop()) {
      return items[3];
    } else if (isNotebook()) {
      return items[2];
    } else if (isTablet()) {
      return items[1];
    } else if (isMobile()) {
      return items[0];
    } else {
      return items[0];
    }
  }

  double getPadding() {
    if (isDesktop()) {
      return items[3];
    } else if (isNotebook()) {
      return items[2];
    } else if (isTablet()) {
      return items[1];
    } else if (isMobile()) {
      return items[0];
    } else {
      return items[0];
    }
  }
}
