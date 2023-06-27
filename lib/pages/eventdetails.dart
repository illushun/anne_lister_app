import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';
import '../styling/card.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key, required this.eventDate});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String eventDate;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  List _eventData = [];

  Future<void> readJson(String date) async {
    final String response = await rootBundle.loadString('assets/events.json');
    final data = await json.decode(response);
    setState(() {
      var events = data["events"];
      for (var i = 0; i < events.length; i++) {
        if (events[i].containsKey(date)) {
          _eventData = events[i][date];
          break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readJson(widget.eventDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    Responsive(
                            minWidth: constraints.maxWidth,
                            items: AppTheme.itemPadding)
                        .getPadding(),
                    60,
                    Responsive(
                            minWidth: constraints.maxWidth,
                            items: AppTheme.itemPadding)
                        .getPadding(),
                    60),
                child: Text(
                  widget.eventDate,
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileTitle,
                    TextStyles.tabletTitle,
                    TextStyles.tabletTitle,
                    TextStyles.desktopTitle
                  ]).getCorrectText(),
                  textAlign: TextAlign.center,
                ),
              ),
              _eventData.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _eventData.length,
                        itemBuilder: (context, index) {
                          return index % 2 != 0
                              ? CardContainer(
                                  leftWidget: _eventData[index]["booking"] ==
                                          "Required"
                                      ? Stack(
                                          children: [
                                            ActivityCard(
                                                activityInfo: _eventData[index],
                                                currentIndex: index),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                    Icons.warning_rounded,
                                                    size: Responsive(
                                                        minWidth: constraints
                                                            .maxWidth,
                                                        items: [
                                                          100.0,
                                                          100.0,
                                                          100.0,
                                                          150.0
                                                        ]).getPadding(),
                                                    color: Colors.red)),
                                          ],
                                        )
                                      : ActivityCard(
                                          activityInfo: _eventData[index],
                                          currentIndex: index),
                                  rightWidget: Center(
                                    child: SvgPicture.asset(
                                        "assets/images/symbols/arrow_left_rounded.svg",
                                        width: 100,
                                        height: 100,
                                        colorFilter: const ColorFilter.mode(
                                            AppTheme.primaryBtnBackground,
                                            BlendMode.srcIn)),
                                  ))
                              : CardContainer(
                                  sideLeft: false,
                                  leftWidget: Center(
                                    child: index == 0
                                        ? const Icon(Icons.flag_rounded,
                                            color:
                                                AppTheme.primaryBtnBackground,
                                            size: 120)
                                        : SvgPicture.asset(
                                            "assets/images/symbols/arrow_right_rounded.svg",
                                            width: 100,
                                            height: 100,
                                            colorFilter: const ColorFilter.mode(
                                                AppTheme.primaryBtnBackground,
                                                BlendMode.srcIn)),
                                  ),
                                  rightWidget: _eventData[index]["booking"] ==
                                          "Required"
                                      ? Stack(
                                          children: [
                                            ActivityCard(
                                                activityInfo: _eventData[index],
                                                currentIndex: index),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                    Icons.warning_rounded,
                                                    size: Responsive(
                                                        minWidth: constraints
                                                            .maxWidth,
                                                        items: [
                                                          100.0,
                                                          100.0,
                                                          100.0,
                                                          150.0
                                                        ]).getPadding(),
                                                    color: Colors.red)),
                                          ],
                                        )
                                      : ActivityCard(
                                          activityInfo: _eventData[index],
                                          currentIndex: index));
                        },
                      ),
                    )
                  : Container(),
              Footer(
                  text:
                      'This application was created to celebrate the birthday of Anne Lister, a pioneering English landowner, diarist, mountaineer, and lesbian. Born on April 3, 1791, Lister left behind a detailed account of her life and relationships, known as the "secret diaries," which provide a unique insight into the social and cultural norms of the 19th century. We hope that this application helps to raise awareness of Lister\'s legacy and inspires others to explore her remarkable story.'),
            ],
          );
        }),
      ),
    );
  }
}
