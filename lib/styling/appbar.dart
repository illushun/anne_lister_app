import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styling/styles.dart';

AppBar getAppBar() {
  return AppBar(
    title: Container(
      width: 150,
      child: SvgPicture.asset(
        "assets/images/calderdale_logo.svg",
        width: 300,
        height: 300,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: AppTheme.hamburgerIcon),
    shadowColor: AppTheme.cardDropShadow,
  );
}
