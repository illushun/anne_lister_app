import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:html' as html;
//import 'package:url_launcher/url_launcher.dart';

import 'styles.dart';
import 'responsive.dart';
import 'gradient_tile.dart';

class CardContainer extends StatelessWidget {
  Widget leftWidget;
  Widget rightWidget;
  bool sideLeft;

  CardContainer(
      {this.sideLeft = true,
      required this.leftWidget,
      required this.rightWidget});

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
          //padding: const EdgeInsets.all(20),
          child: sideLeft
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: leftWidget,
                    ),
                    Responsive(minWidth: constraints.maxWidth).isNotebook() ||
                            Responsive(minWidth: constraints.maxWidth)
                                .isDesktop()
                        ? Expanded(
                            flex: 1,
                            child: Container(
                              child: rightWidget,
                            ),
                          )
                        : Container(),
                  ],
                )
              : Row(
                  children: <Widget>[
                    Responsive(minWidth: constraints.maxWidth).isNotebook() ||
                            Responsive(minWidth: constraints.maxWidth)
                                .isDesktop()
                        ? Expanded(
                            flex: 1,
                            child: leftWidget,
                          )
                        : Container(),
                    Expanded(
                      flex: 1,
                      child: rightWidget,
                    ),
                  ],
                ));
    });
  }
}

class ActivityCard extends StatelessWidget {
  Map activityInfo;
  int currentIndex;

  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  List<Widget> getEventImages() {
    List<Widget> images = [];
    for (var i = 0; i < activityInfo["images"].length; i++) {
      images.add(Image(image: AssetImage(activityInfo["images"][i])));
    }
    return images;
  }

  String getKeyFromIndex(int index) {
    switch (index) {
      case 0:
        return "name";
      case 1:
        return "location";
      case 2:
        return "information";
      case 3:
        return "start";
      case 4:
        return "end";
      case 5:
        return "booking";
      case 6:
        return "website";
      default:
        return "website";
    }
  }

  ActivityCard({required this.activityInfo, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: CardStyles.cardBorderRadius,
          boxShadow: [
            CardStyles.cardDropShadow,
          ],
        ),
        child: Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              ImageListTile(
                  title: activityInfo["name"],
                  onTap: () {},
                  image: 'assets/images/section-bg.png',
                  radius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: activityInfo.length - 2,
                  itemBuilder: (context, j) {
                    return GestureDetector(
                      onTap: () {
                        if (activityInfo["website"] != "") {
                          openUrl(activityInfo["website"]);
                        }
                      },
                      child: ListTile(
                        tileColor: j % 2 != 0
                            ? AppTheme.tableSubHeadingBackground
                            : Colors.white,
                        title: j == 0
                            ? getEventImages().length > 1
                                ? CarouselSlider(
                                    items: getEventImages(),
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      aspectRatio: constraints.maxWidth > 1200
                                          ? 4 / 1
                                          : constraints.maxWidth > 1024
                                              ? 4 / 2
                                              : constraints.maxWidth > 768
                                                  ? 8 / 4
                                                  : 16 / 9,
                                    ),
                                  )
                                : AspectRatio(
                                    aspectRatio: constraints.maxWidth > 1200
                                        ? 4 / 1
                                        : constraints.maxWidth > 1024
                                            ? 4 / 2
                                            : constraints.maxWidth > 768
                                                ? 8 / 4
                                                : 16 / 9,
                                    child: Image(
                                      image:
                                          AssetImage(activityInfo["images"][0]),
                                    ),
                                  )
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  j > 2
                                      ? '${StringUtils.capitalize(getKeyFromIndex(j))}: ${activityInfo[getKeyFromIndex(j)]}'
                                      : '${activityInfo[getKeyFromIndex(j)]}',
                                  style: Responsive(
                                      minWidth: constraints.maxWidth,
                                      items: [
                                        TextStyles.mobileTableSubHeading,
                                        TextStyles.tabletTableSubHeading,
                                        TextStyles.tabletTableSubHeading,
                                        TextStyles.desktopTableSubHeading
                                      ]).getCorrectText(),
                                ),
                              ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: AppTheme.tableOutline,
                            width: 1,
                          ),
                          borderRadius: j == (activityInfo.length - 2) - 1
                              ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                )
                              : BorderRadius.zero,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }
}

class HighlightCard extends StatelessWidget {
  String heading;
  String subHeading;

  HighlightCard({required this.heading, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: 600,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(
                'assets/images/60ba5985f394bf1012c0c83a_Comp 1 - v2-transcode.jpg'),
            fit: BoxFit.cover,
          ),
          color: AppTheme.cardBackground,
          borderRadius: CardStyles.cardBorderRadius,
          boxShadow: [
            CardStyles.cardDropShadow,
          ],
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: AppTheme.tableOutline,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 0,
          child: Column(
            children: <Widget>[
              ListTile(
                tileColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    heading,
                    style: Responsive(minWidth: constraints.maxWidth, items: [
                      TextStyles.mobileLightTableHeading,
                      TextStyles.tabletLightTableHeading,
                      TextStyles.tabletLightTableHeading,
                      TextStyles.desktopLightTableHeading
                    ]).getCorrectText(),
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppTheme.tableOutline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
              ListTile(
                tileColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    subHeading,
                    style: Responsive(minWidth: constraints.maxWidth, items: [
                      TextStyles.mobileTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.desktopTableSubHeading
                    ]).getCorrectText(),
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppTheme.tableOutline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class EventCard extends StatelessWidget {
  Map eventData;
  VoidCallback onTap;

  EventCard({required this.eventData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: 500,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(eventData["images"][0]),
              fit: BoxFit.cover,
            ),
            color: AppTheme.cardBackground,
            borderRadius: CardStyles.cardBorderRadius,
            boxShadow: [
              CardStyles.cardDropShadow,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.background,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          AppTheme.background.withAlpha(20),
                          AppTheme.background
                        ],
                        stops: const [
                          0.0,
                          0.5
                        ])),
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          tileColor: Colors.transparent,
                          title: Container(height: 80)),
                      ListTile(
                        tileColor: Colors.transparent,
                        title: Text(
                          eventData["name"].length > 40
                              ? eventData["name"].substring(0, 40) + '...'
                              : eventData["name"],
                          style: Responsive(
                              minWidth: constraints.maxWidth,
                              items: [
                                TextStyles.mobileTableSubHeading,
                                TextStyles.tabletTableSubHeading,
                                TextStyles.tabletTableSubHeading,
                                TextStyles.desktopTableSubHeading
                              ]).getCorrectText(),
                        ),
                        subtitle: Text(
                          '${eventData["start"]} - ${eventData["end"]}',
                          style: Responsive(
                              minWidth: constraints.maxWidth,
                              items: [
                                TextStyles.mobileTableExtraInfo,
                                TextStyles.tabletTableExtraInfo,
                                TextStyles.tabletTableExtraInfo,
                                TextStyles.desktopTableExtraInfo
                              ]).getCorrectText(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class EventListTileSingle extends StatelessWidget {
  String heading;
  String subHeading;
  String extraInfo;

  EventListTileSingle(
      {required this.heading, required this.subHeading, this.extraInfo = ''});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: EdgeInsets.fromLTRB(
            Responsive(
                    minWidth: constraints.maxWidth, items: AppTheme.itemPadding)
                .getPadding(),
            10,
            Responsive(
                    minWidth: constraints.maxWidth, items: AppTheme.itemPadding)
                .getPadding(),
            10),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: CardStyles.cardBorderRadius,
          boxShadow: [
            CardStyles.cardDropShadow,
          ],
        ),
        child: Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              ImageListTile(
                title: heading,
                onTap: () {},
                image: 'assets/images/section-bg.png',
                radius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              ListTile(
                tileColor: AppTheme.tableSubHeadingBackground,
                title: Text(
                  subHeading,
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileTableSubHeading,
                    TextStyles.tabletTableSubHeading,
                    TextStyles.tabletTableSubHeading,
                    TextStyles.desktopTableSubHeading
                  ]).getCorrectText(),
                ),
                subtitle: Text(
                  extraInfo,
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileTableExtraInfo,
                    TextStyles.tabletTableExtraInfo,
                    TextStyles.tabletTableExtraInfo,
                    TextStyles.desktopTableExtraInfo
                  ]).getCorrectText(),
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppTheme.tableOutline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
