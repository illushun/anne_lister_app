import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'styles.dart';
import 'responsive.dart';

class Footer extends StatelessWidget {
  String text;

  Footer({required this.text});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(
              Responsive(
                      minWidth: constraints.maxWidth,
                      items: AppTheme.itemPadding)
                  .getPadding(),
              10,
              Responsive(
                      minWidth: constraints.maxWidth,
                      items: AppTheme.itemPadding)
                  .getPadding(),
              10),
          padding: const EdgeInsets.all(10),
          child: Responsive(minWidth: constraints.maxWidth).isNotebook() ||
                  Responsive(minWidth: constraints.maxWidth).isDesktop()
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        "assets/images/calderdale_college_logo.svg",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          text,
                          style: Responsive(
                              minWidth: constraints.maxWidth,
                              items: [
                                TextStyles.mobileFooter,
                                TextStyles.tabletFooter,
                                TextStyles.tabletFooter,
                                TextStyles.desktopFooter
                              ]).getCorrectText(),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: SvgPicture.asset(
                        "assets/images/calderdale_college_logo.svg",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Container(
                      child: Text(
                        text,
                        style:
                            Responsive(minWidth: constraints.maxWidth, items: [
                          TextStyles.mobileFooter,
                          TextStyles.tabletFooter,
                          TextStyles.tabletFooter,
                          TextStyles.desktopFooter
                        ]).getCorrectText(),
                      ),
                    ),
                  ],
                ));
    });
  }
}
