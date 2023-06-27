import 'package:flutter/material.dart';

import 'styles.dart';
import 'responsive.dart';

class SectionListTile extends StatelessWidget {
  String title;
  String subtitle;
  String buttonTitle;
  VoidCallback onTap;
  Color backgroundColour;
  String backgroundImage;
  String image;
  bool lightMode;

  SectionListTile(
      {required this.title,
      required this.subtitle,
      required this.buttonTitle,
      required this.onTap,
      this.backgroundColour = AppTheme.background,
      this.backgroundImage = '',
      required this.image,
      this.lightMode = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Card(
              elevation: 0,
              child: Container(
                color: backgroundColour,
                /*decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),*/
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    decoration: backgroundImage.isNotEmpty
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(backgroundImage),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const BoxDecoration(),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          Responsive(
                                  minWidth: constraints.maxWidth,
                                  items: AppTheme.itemPadding)
                              .getPadding(),
                          20,
                          Responsive(
                                  minWidth: constraints.maxWidth,
                                  items: AppTheme.itemPadding)
                              .getPadding(),
                          20),
                      child: Stack(
                        children: [
                          Container(
                            width: constraints.maxWidth > 1200
                                ? 1000
                                : constraints.maxWidth > 1024
                                    ? 700
                                    : constraints.maxWidth > 900
                                        ? 600
                                        : constraints.maxWidth > 768
                                            ? 400
                                            : 1050,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: ListTile(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        title,
                                        style: Responsive(
                                            minWidth: constraints.maxWidth,
                                            items: [
                                              lightMode
                                                  ? TextStyles
                                                      .mobileLightHeroSectionHeading
                                                  : TextStyles
                                                      .mobileHeroSectionHeading,
                                              lightMode
                                                  ? TextStyles
                                                      .tabletLightHeroSectionHeading
                                                  : TextStyles
                                                      .tabletHeroSectionHeading,
                                              lightMode
                                                  ? TextStyles
                                                      .tabletLightHeroSectionHeading
                                                  : TextStyles
                                                      .tabletHeroSectionHeading,
                                              lightMode
                                                  ? TextStyles
                                                      .desktopLightHeroSectionHeading
                                                  : TextStyles
                                                      .desktopHeroSectionHeading
                                            ]).getCorrectText(),
                                      ),
                                    ),
                                    subtitle: Text(
                                      subtitle,
                                      style: Responsive(
                                          minWidth: constraints.maxWidth,
                                          items: [
                                            lightMode
                                                ? TextStyles
                                                    .tabletLightHeroSectionSubHeading
                                                : TextStyles
                                                    .mobileHeroSectionSubHeading,
                                            lightMode
                                                ? TextStyles
                                                    .tabletLightHeroSectionSubHeading
                                                : TextStyles
                                                    .tabletHeroSectionSubHeading,
                                            lightMode
                                                ? TextStyles
                                                    .tabletLightHeroSectionSubHeading
                                                : TextStyles
                                                    .tabletHeroSectionSubHeading,
                                            lightMode
                                                ? TextStyles
                                                    .tabletLightHeroSectionSubHeading
                                                : TextStyles
                                                    .desktopHeroSectionSubHeading
                                          ]).getCorrectText(),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 20),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: image.isNotEmpty ? 20 : 40),
                                      height: 50,
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: onTap,
                                        style: lightMode
                                            ? ButtonStyles.primary
                                            : ButtonStyles.heroSection,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              buttonTitle,
                                              style: TextStyles.primaryBtn,
                                            ),
                                            const Icon(
                                                Icons.keyboard_arrow_right)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          image.isNotEmpty
                              ? constraints.maxWidth > 768
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          image,
                                          height: constraints.maxWidth > 768
                                              ? 300
                                              : 150,
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageListTile extends StatelessWidget {
  String title;
  VoidCallback onTap;
  String image;
  BorderRadius radius;

  ImageListTile(
      {required this.title,
      required this.onTap,
      required this.image,
      this.radius = const BorderRadius.all(Radius.circular(10))});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Card(
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      title,
                      style: Responsive(minWidth: constraints.maxWidth, items: [
                        TextStyles.mobileTableHeading,
                        TextStyles.tabletTableHeading,
                        TextStyles.tabletTableHeading,
                        TextStyles.desktopTableHeading
                      ]).getCorrectText(),
                    ),
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

class GradientListTile extends StatelessWidget {
  String title;
  VoidCallback onTap;
  List<Color> colours;
  BorderRadius radius;

  GradientListTile(
      {required this.title,
      required this.onTap,
      required this.colours,
      this.radius = const BorderRadius.all(Radius.circular(10))});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Card(
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colours,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      title,
                      style: Responsive(minWidth: constraints.maxWidth, items: [
                        TextStyles.mobileTableHeading,
                        TextStyles.tabletTableHeading,
                        TextStyles.tabletTableHeading,
                        TextStyles.desktopTableHeading
                      ]).getCorrectText(),
                    ),
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
