import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color.fromARGB(255, 244, 245, 249);
  static const Color backgroundFooter = Color.fromARGB(255, 244, 245, 249);
  static const Color textFooter = Color.fromARGB(255, 0, 48, 87);
  static const Color hamburgerIcon = Color.fromARGB(255, 0, 41, 89);
  static const Color textTitle = Color.fromARGB(255, 10, 46, 78);
  static const Color textSection = Color.fromARGB(255, 133, 137, 151);

  static const Color cardBackground = Colors.white;
  static const Color cardDropShadow = Color.fromARGB(255, 220, 219, 226);

  static const Color tableOutline =
      Color.fromARGB(255, 255, 255, 255); // Color.fromARGB(255, 223, 231, 240)
  static const Color tableHeadingBackground = Color.fromARGB(255, 124, 55, 196);
  static const Color tableHeadingText = Colors.white;
  static const Color tableLightHeadingText = Color.fromARGB(255, 0, 48, 87);
  static const Color tableSubHeadingBackground =
      Color.fromARGB(255, 244, 245, 249);
  static const Color tableSubHeadingText = Color.fromARGB(255, 12, 55, 92);
  static const Color tableExtraInfoText = Color.fromARGB(255, 148, 151, 164);

  static const Color primaryBtnBackground = Color.fromARGB(255, 0, 48, 87);
  static const Color primaryBtnText = Colors.white;

  static const Color secondaryBtnBackground =
      Color.fromARGB(255, 242, 242, 252);
  static const Color secondaryBtnText = Color.fromARGB(255, 0, 48, 87);

  static const Color tertiaryBtnBackground = background;
  static const Color tertiaryBtnText = Color.fromARGB(255, 0, 48, 87);

  static const Color cardLinkBtnBackground = Colors.transparent;
  static const Color cardLinkBtnText = Color.fromARGB(255, 20, 63, 166);

  static const Color heroSectionHeadingText = Colors.white;
  static const Color heroSectionSubHeadingText =
      Color.fromARGB(255, 177, 203, 225);

  static const Color heroSectionLightHeadingText = primaryBtnBackground;
  static const Color heroSectionLightSubHeadingText = primaryBtnBackground;

  static const Color heroSectionBtnBackground =
      Color.fromARGB(35, 255, 255, 255);
  static const Color heroSectionBtnText = Colors.white;

  static const List<Color> tileGradient = [
    Color.fromARGB(255, 31, 64, 55),
    Color.fromARGB(255, 153, 242, 200),
  ];

  static const List<double> itemPadding = [20, 60, 80, 120];
}

class TextStyles {
  static const TextStyle mobileFooter = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppTheme.heroSectionLightSubHeadingText,
  );

  static const TextStyle tabletFooter = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppTheme.heroSectionLightSubHeadingText,
  );

  static const TextStyle desktopFooter = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.heroSectionLightSubHeadingText,
  );

  static const TextStyle mobileTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: AppTheme.textTitle,
  );

  static const TextStyle tabletTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48,
    color: AppTheme.textTitle,
  );

  static const TextStyle desktopTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 60,
    color: AppTheme.textTitle,
  );

  static const TextStyle mobileSection = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppTheme.textSection,
  );

  static const TextStyle tabletSection = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22,
    color: AppTheme.textSection,
  );

  static const TextStyle desktopSection = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 26,
    color: AppTheme.textSection,
  );

  static const TextStyle mobileTableHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.tableHeadingText,
  );

  static const TextStyle mobileLightTableHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.tableLightHeadingText,
  );

  static const TextStyle tabletTableHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 23,
    color: AppTheme.tableHeadingText,
  );

  static const TextStyle tabletLightTableHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 23,
    color: AppTheme.tableLightHeadingText,
  );

  static const TextStyle desktopTableHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 28,
    color: AppTheme.tableHeadingText,
  );

  static const TextStyle desktopLightTableHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 28,
    color: AppTheme.tableLightHeadingText,
  );

  static const TextStyle mobileTableSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppTheme.tableSubHeadingText,
  );

  static const TextStyle tabletTableSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppTheme.tableSubHeadingText,
  );

  static const TextStyle desktopTableSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.tableSubHeadingText,
  );

  static const TextStyle mobileTableExtraInfo = TextStyle(
    color: AppTheme.tableExtraInfoText,
  );

  static const TextStyle tabletTableExtraInfo = TextStyle(
    color: AppTheme.tableExtraInfoText,
    fontSize: 15,
  );

  static const TextStyle desktopTableExtraInfo = TextStyle(
    color: AppTheme.tableExtraInfoText,
    fontSize: 17,
  );

  static const TextStyle mobileHeroSectionHeading = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: AppTheme.heroSectionHeadingText,
  );

  static const TextStyle mobileLightHeroSectionHeading = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: AppTheme.heroSectionLightHeadingText,
  );

  static const TextStyle tabletHeroSectionHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 48,
    color: AppTheme.heroSectionHeadingText,
  );

  static const TextStyle tabletLightHeroSectionHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 48,
    color: AppTheme.heroSectionLightHeadingText,
  );

  static const TextStyle desktopHeroSectionHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 60,
    color: AppTheme.heroSectionHeadingText,
  );

  static const TextStyle desktopLightHeroSectionHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 60,
    color: AppTheme.heroSectionLightHeadingText,
  );

  static const TextStyle mobileHeroSectionSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppTheme.heroSectionSubHeadingText,
  );

  static const TextStyle mobileLightHeroSectionSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppTheme.heroSectionLightSubHeadingText,
  );

  static const TextStyle tabletHeroSectionSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppTheme.heroSectionSubHeadingText,
  );

  static const TextStyle tabletLightHeroSectionSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: AppTheme.heroSectionLightSubHeadingText,
  );

  static const TextStyle desktopHeroSectionSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.heroSectionSubHeadingText,
  );

  static const TextStyle desktopLightHeroSectionSubHeading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: AppTheme.heroSectionLightSubHeadingText,
  );

  static const TextStyle primaryBtn = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  static const TextStyle secondaryBtn = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );

  static const TextStyle tertiaryBtn = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 17,
  );

  static const TextStyle cardLinkBtn = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );
}

class ButtonStyles {
  static ButtonStyle primary = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppTheme.primaryBtnBackground,
    foregroundColor: AppTheme.primaryBtnText,
  );

  static ButtonStyle secondary = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppTheme.secondaryBtnBackground,
    foregroundColor: AppTheme.secondaryBtnText,
  );

  static ButtonStyle tertiary = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppTheme.tertiaryBtnBackground,
    foregroundColor: AppTheme.tertiaryBtnText,
  );

  static ButtonStyle cardLink = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppTheme.cardLinkBtnBackground,
    foregroundColor: AppTheme.cardLinkBtnText,
  );

  static ButtonStyle heroSection = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppTheme.heroSectionBtnBackground,
    foregroundColor: AppTheme.heroSectionBtnText,
  );
}

class CardStyles {
  static BoxShadow cardDropShadow = const BoxShadow(
    color: AppTheme.cardDropShadow,
    offset: Offset(0, 5),
    blurRadius: 7,
  );

  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(20));
}
