import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'events.dart';
import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/card.dart';
import '../styling/gradient_tile.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';

class PartnershipsPage extends StatefulWidget {
  const PartnershipsPage({super.key});

  @override
  State<PartnershipsPage> createState() => _PartnershipsPageState();
}

class _PartnershipsPageState extends State<PartnershipsPage> {
  void openUrl(String url) {
    html.window.open(url, '_blank');
  }

  @override
  void initState() {
    super.initState();
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
                    'Partnerships',
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
                      60),
                  child: Text(
                    'We are proud to be working with the following organisations:',
                    textAlign: TextAlign.center,
                    style: Responsive(minWidth: constraints.maxWidth, items: [
                      TextStyles.mobileTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.desktopTableSubHeading
                    ]).getCorrectText(),
                  ),
                ),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: GestureDetector(
                    onTap: () {
                      openUrl('https://halifaxminster.org.uk/');
                    },
                    child: Image.asset(
                      'assets/images/partnerships/halifax_minster_logo.png',
                      width: 500,
                    ),
                  ),
                ),
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
                      60),
                  child: Text(
                    'Halifax minster is a Grade I listed building and the largest parish church in the UK. It is home to the world\'s largest fan-vaulted ceiling and is a popular tourist attraction.',
                    textAlign: TextAlign.center,
                    style: Responsive(minWidth: constraints.maxWidth, items: [
                      TextStyles.mobileTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.desktopTableSubHeading
                    ]).getCorrectText(),
                  ),
                ),
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
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 20),
                  child: GestureDetector(
                    onTap: () {
                      openUrl('https://www.wyjs.org.uk/archive-service/');
                    },
                    child: Image.asset(
                      'assets/images/partnerships/wy_archive_service_logo.jpg',
                      width: 500,
                    ),
                  ),
                ),
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
                      120),
                  child: Text(
                    'West yorkshire archive service is a public body that collects, preserves and makes accessible the records of West Yorkshire. It is responsible for the care of the Anne Lister archive, which is held at the West Yorkshire archive service\'s headquarters in Wakefield.',
                    textAlign: TextAlign.center,
                    style: Responsive(minWidth: constraints.maxWidth, items: [
                      TextStyles.mobileTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.tabletTableSubHeading,
                      TextStyles.desktopTableSubHeading
                    ]).getCorrectText(),
                  ),
                ),
                Footer(
                    text:
                        'This application was created to celebrate the birthday of Anne Lister, a pioneering English landowner, diarist, mountaineer, and lesbian. Born on April 3, 1791, Lister left behind a detailed account of her life and relationships, known as the "secret diaries," which provide a unique insight into the social and cultural norms of the 19th century. We hope that this application helps to raise awareness of Lister\'s legacy and inspires others to explore her remarkable story.'),
              ],
            );
          }),
        ));
  }
}
