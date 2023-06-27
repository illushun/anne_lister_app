import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'dart:convert';

import 'events.dart';
import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/card.dart';
import '../styling/gradient_tile.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';

import '../json.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List _testData = [];
  List _nextEvents = [];

  Future<void> readJson(String date) async {
    final String response = await rootBundle.loadString('assets/events.json');
    final data = await json.decode(response);
    setState(() {
      var events = data["events"];
      for (var i = 0; i < events.length; i++) {
        if (events[i].containsKey(date)) {
          _testData = events[i][date];
          break;
        }
      }
    });
  }

  void getNextEvents(String date) {
    _nextEvents.clear();
    List dateVars = date.split("-");
    String correctDate = "${dateVars[2]}-${dateVars[1]}-${dateVars[0]}";

    for (var i = 0; i < _testData.length; i++) {
      String startTime = _testData[i]["start"];
      var ukTime = DateTime.parse('$correctDate $startTime').toLocal();

      if (DateTime.now().isBefore(ukTime)) {
        _nextEvents.add(_testData[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readJson(Events().getClosestEventDate());
  }

  @override
  Widget build(BuildContext context) {
    getNextEvents(Events().getClosestEventDate());
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
                    0,
                    Responsive(
                            minWidth: constraints.maxWidth,
                            items: AppTheme.itemPadding)
                        .getPadding(),
                    0),
                margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Image.asset(
                  'assets/images/partnerships/festival_large_web_banner.jpg',
                  width: 500,
                ),
              ),
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
                  'Anne Lister\'s Birthday Festival 2023!',
                  textAlign: TextAlign.center,
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileTitle,
                    TextStyles.tabletTitle,
                    TextStyles.tabletTitle,
                    TextStyles.desktopTitle
                  ]).getCorrectText(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 60),
                child: SectionListTile(
                  title: 'Who was Anne Lister?',
                  subtitle:
                      'Anne was a remarkable woman: landowner, entrepreneur, mountaineer, scholar, traveller, and lesbian. Her fascinating diaries of some five million words – one-sixth of which was written in a secret code...',
                  buttonTitle: 'Read More',
                  onTap: () {
                    Navigator.pushNamed(context, '/anneLister');
                  },
                  backgroundImage: 'assets/images/big-section-bg-cut.png',
                  image: '',
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
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
                    20),
                child: Text(
                  'Next Activity',
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileSection,
                    TextStyles.tabletSection,
                    TextStyles.tabletSection,
                    TextStyles.desktopSection
                  ]).getCorrectText(),
                ),
              ),
              _nextEvents.isEmpty
                  ? Container(
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
                      alignment: Alignment.center,
                      child: Text('No Activities to Display...',
                          style: Responsive(
                              minWidth: constraints.maxWidth,
                              items: [
                                TextStyles.mobileTableSubHeading,
                                TextStyles.tabletTableSubHeading,
                                TextStyles.tabletTableSubHeading,
                                TextStyles.desktopTableSubHeading
                              ]).getCorrectText()))
                  : Container(
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
                        itemCount: _nextEvents.length > 1 ? 4 : 1,
                        itemBuilder: (context, index) {
                          return Container(
                              margin:
                                  EdgeInsets.only(right: index < 3 ? 20 : 0),
                              child: index < 3
                                  ? Container(
                                      padding: index != 0 && index != 3
                                          ? EdgeInsets.only(
                                              top: 10.0 * index,
                                              bottom: 10.0 * index)
                                          : null,
                                      child: EventCard(
                                          eventData: _nextEvents[index],
                                          onTap: () {}),
                                    )
                                  : Container(
                                      width: 200,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 224, 226, 235),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                            '+${_nextEvents.length - 3} More',
                                            style: TextStyles.cardLinkBtn),
                                      )));
                        },
                      ),
                    ),
              Container(
                alignment: Alignment.centerLeft,
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
                    20),
                child: Text(
                  'Upcoming Activities (${Events().getClosestEventDate()})',
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileSection,
                    TextStyles.tabletSection,
                    TextStyles.tabletSection,
                    TextStyles.desktopSection
                  ]).getCorrectText(),
                ),
              ),
              _testData.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _testData.length > 3 ? 3 : _testData.length,
                        itemBuilder: (context, index) {
                          return EventListTileSingle(
                              heading: _testData[index]["name"],
                              subHeading: _testData[index]["location"],
                              extraInfo:
                                  '${_testData[index]["start"]} - ${_testData[index]["end"]}');
                        },
                      ),
                    )
                  : Container(),
              Container(
                height: 50,
                width: 200,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/${Events().getClosestEventDate()}');
                  },
                  style: ButtonStyles.primary,
                  child: const Text(
                    'View All Activities',
                    style: TextStyles.primaryBtn,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 60),
                child: SectionListTile(
                  title: 'Decrypt Anne\'s Code!',
                  subtitle:
                      'Have a crack at decyphering words using Anne\'s code... see if you can get them all right!',
                  buttonTitle: 'I\'m Ready!',
                  onTap: () {
                    Navigator.pushNamed(context, '/encryptor');
                  },
                  backgroundImage: 'assets/images/big-section-bg.png',
                  image: 'assets/images/blue-clay.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 60),
                child: SectionListTile(
                  title: 'New to Halifax?',
                  subtitle:
                      'Venturing to a new place can be daunting, why not view our wide range of services available at your fingertips.',
                  buttonTitle: 'Take Me There!',
                  onTap: () {
                    Navigator.pushNamed(context, '/importantServices');
                  },
                  backgroundColour: AppTheme.background,
                  image: 'assets/images/3d_bike.png',
                  lightMode: true,
                ),
              ),
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
