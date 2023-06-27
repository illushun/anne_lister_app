import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:basic_utils/basic_utils.dart';
import 'dart:convert';
import 'package:map_launcher/map_launcher.dart';

import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/gradient_tile.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';

class ImportantServicesPage extends StatefulWidget {
  const ImportantServicesPage({super.key});

  @override
  State<ImportantServicesPage> createState() => _ImportantServicesState();
}

class _ImportantServicesState extends State<ImportantServicesPage> {
  Map<String, dynamic> _serviceData = {};

  openMapsSheet(context) async {
    try {
      final title = "Shanghai Tower";
      final description = "Asia's tallest building";
      final coords = Coords(31.233568, 121.505504);
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/services.json');
    final data = await json.decode(response);
    setState(() {
      _serviceData = data["services"];
    });
  }

  String getServiceFromIndex(int index) {
    switch (index) {
      case 0:
        return "police";
      case 1:
        return "fire";
      case 2:
        return "ambulance";
      case 3:
        return "hospital";
      case 4:
        return "cashpoint";
      default:
        return "police";
    }
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
                  'Services Available',
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileSection,
                    TextStyles.tabletSection,
                    TextStyles.tabletSection,
                    TextStyles.desktopSection
                  ]).getCorrectText(),
                ),
              ),
              _serviceData.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _serviceData.length,
                        itemBuilder: (context, i) {
                          return Container(
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
                                      title: StringUtils.capitalize(
                                          getServiceFromIndex(i)),
                                      onTap: () {},
                                      image: 'assets/images/section-bg.png',
                                      radius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          _serviceData[getServiceFromIndex(i)]
                                              .length,
                                      itemBuilder: (context, j) {
                                        return ListTile(
                                          tileColor: AppTheme
                                              .tableSubHeadingBackground,
                                          title: Text(
                                            _serviceData[getServiceFromIndex(i)]
                                                [j]["name"],
                                            style: Responsive(
                                                minWidth: constraints.maxWidth,
                                                items: [
                                                  TextStyles
                                                      .mobileTableSubHeading,
                                                  TextStyles
                                                      .tabletTableSubHeading,
                                                  TextStyles
                                                      .tabletTableSubHeading,
                                                  TextStyles
                                                      .desktopTableSubHeading
                                                ]).getCorrectText(),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                      right: 10,
                                                      bottom: 5,
                                                    ),
                                                    child: const Icon(
                                                        Icons.location_pin),
                                                  ),
                                                  Text(
                                                    _serviceData[
                                                        getServiceFromIndex(
                                                            i)][j]["address"],
                                                    style: Responsive(
                                                        minWidth: constraints
                                                            .maxWidth,
                                                        items: [
                                                          TextStyles
                                                              .mobileTableExtraInfo,
                                                          TextStyles
                                                              .tabletTableExtraInfo,
                                                          TextStyles
                                                              .tabletTableExtraInfo,
                                                          TextStyles
                                                              .desktopTableExtraInfo
                                                        ]).getCorrectText(),
                                                  ),
                                                ],
                                              ),
                                              _serviceData[getServiceFromIndex(
                                                          i)][j]["phone"] !=
                                                      ""
                                                  ? Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 10,
                                                            top: 5,
                                                            bottom: 5,
                                                          ),
                                                          child: const Icon(
                                                              Icons.phone),
                                                        ),
                                                        Text(
                                                          _serviceData[
                                                              getServiceFromIndex(
                                                                  i)][j]["phone"],
                                                          style: Responsive(
                                                              minWidth:
                                                                  constraints
                                                                      .maxWidth,
                                                              items: [
                                                                TextStyles
                                                                    .mobileTableExtraInfo,
                                                                TextStyles
                                                                    .tabletTableExtraInfo,
                                                                TextStyles
                                                                    .tabletTableExtraInfo,
                                                                TextStyles
                                                                    .desktopTableExtraInfo
                                                              ]).getCorrectText(),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(),
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color: AppTheme.tableOutline,
                                              width: 1,
                                            ),
                                            borderRadius: j ==
                                                    _serviceData[
                                                                getServiceFromIndex(
                                                                    i)]
                                                            .length -
                                                        1
                                                ? const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  )
                                                : BorderRadius.zero,
                                          ),
                                          onTap: () => {
                                          },
                                        );
                                      }),
                                ],
                              ),
                            ),
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
