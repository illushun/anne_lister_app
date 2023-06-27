import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';
import '../styling/card.dart';

class Events {
  Events();

  List<String> getDates() {
    return [
      "27-03-2023",
      "28-03-2023",
      "29-03-2023",
      "30-03-2023",
      "31-03-2023",
      "01-04-2023",
      "02-04-2023",
      "03-04-2023",
      "04-04-2023"
    ];
  }

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getClosestEventDate() {
    List dates = getDates();
    String currentDate = getCurrentDate();

    for (var i = 0; i < dates.length; i++) {
      var date = [
        int.parse(dates[i].substring(0, 2)), // day
        int.parse(dates[i].substring(3, 5)), // month
        int.parse(dates[i].substring(6, 10)) // year
      ];
      var currDate = [
        int.parse(currentDate.substring(0, 2)), // day
        int.parse(currentDate.substring(3, 5)), // month
        int.parse(currentDate.substring(6, 10)) // year
      ];

      if (currDate[2] > date[2]) {
        // year is in the past
        continue;
      }

      if (currDate[1] > date[1]) {
        // month is in the past
        continue;
      }

      if ((currDate[1] == date[1]) && currDate[0] > date[0]) {
        // day is in the past
        continue;
      }
      return dates[i];
    }
    return "27-03-2023";
  }
}

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List _events = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/events.json');
    final data = await json.decode(response);
    setState(() {
      var eventList = data["events"];
      for (var i = 0; i < eventList.length; i++) {
        for (var date in Events().getDates()) {
          _events.add(eventList[i][date]);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
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
              _events.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _events.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              i != 0
                                  ? Container(
                                      margin: EdgeInsets.fromLTRB(
                                          Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: AppTheme.itemPadding)
                                              .getPadding(),
                                          10,
                                          Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: AppTheme.itemPadding)
                                              .getPadding(),
                                          60),
                                      child: const Divider())
                                  : Container(),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(
                                    Responsive(
                                            minWidth: constraints.maxWidth,
                                            items: AppTheme.itemPadding)
                                        .getPadding(),
                                    i != 0 ? 20 : 80,
                                    Responsive(
                                            minWidth: constraints.maxWidth,
                                            items: AppTheme.itemPadding)
                                        .getPadding(),
                                    20),
                                child: Text(Events().getDates()[i],
                                    style: Responsive(
                                        minWidth: constraints.maxWidth,
                                        items: [
                                          TextStyles.mobileSection,
                                          TextStyles.tabletSection,
                                          TextStyles.tabletSection,
                                          TextStyles.desktopSection
                                        ]).getCorrectText()),
                              ),
                              Container(
                                height: 320,
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
                                    60),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _events[i].length > 1 ? 4 : 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.only(
                                            right: index < 3 ? 20 : 0),
                                        child: index < 3
                                            ? Container(
                                                padding: index != 0 &&
                                                        index != 3
                                                    ? EdgeInsets.only(
                                                        top: 10.0 * index,
                                                        bottom: 10.0 * index)
                                                    : null,
                                                child: EventCard(
                                                    eventData: _events[i]
                                                        [index],
                                                    onTap: () {}),
                                              )
                                            : Container(
                                                width: 200,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 224, 226, 235),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                      '+${_events[i].length - 3} More',
                                                      style: TextStyles
                                                          .cardLinkBtn),
                                                )));
                                  },
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 200,
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/${Events().getDates()[i]}');
                                  },
                                  style: ButtonStyles.primary,
                                  child: const Text(
                                    'View All Activities',
                                    style: TextStyles.primaryBtn,
                                  ),
                                ),
                              ),
                            ],
                          );
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
