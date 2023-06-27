import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/card.dart';
import '../styling/gradient_tile.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';

class AnneListerPage extends StatefulWidget {
  const AnneListerPage({super.key});

  @override
  State<AnneListerPage> createState() => _AnneListerPageState();
}

class _AnneListerPageState extends State<AnneListerPage> {
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
                  'Who was Anne Lister?',
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
                  'Anne Lister was a British landowner, diarist, and traveller who lived from 1791 to 1840. She is remembered for her detailed diaries, which documented her personal life, her travels, and her lesbian relationships. Her diaries were written in a secret code that was deciphered in the 1930s, revealing the full extent of her personal life.',
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileTableSubHeading,
                    TextStyles.tabletTableSubHeading,
                    TextStyles.tabletTableSubHeading,
                    TextStyles.desktopTableSubHeading
                  ]).getCorrectText(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 60),
                child: CardContainer(
                  leftWidget: HighlightCard(
                      heading: 'Early Life and Education',
                      subHeading:
                          'Anne Lister was born on April 3, 1791, in Halifax, West Yorkshire, England, to Jeremy Lister and Rebecca Battle. She was the second child and only daughter of the couple. Her father was a wealthy landowner and a captain in the British Army. Anne was sent to school in York, where she received an education in a variety of subjects, including languages, mathematics, and literature. She was known to be an excellent student and had a passion for learning. After completing her education, Anne returned to Halifax and began managing her family\'s estates. She quickly established herself as a shrewd businesswoman and made several successful investments.'),
                  rightWidget: const Icon(Icons.emoji_flags_rounded,
                      color: AppTheme.primaryBtnBackground, size: 120),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: CardContainer(
                  sideLeft: false,
                  leftWidget: const Icon(Icons.book_outlined,
                      color: AppTheme.primaryBtnBackground, size: 120),
                  rightWidget: HighlightCard(
                      heading: 'Personal Life',
                      subHeading:
                          'Anne Lister was a lesbian, and her diaries documented her romantic relationships with other women. She was known to be a confident and assertive woman who pursued her romantic interests with determination. In 1834, Anne met Ann Walker, a wealthy heiress from nearby Lightcliffe. The two women quickly became close, and Anne proposed marriage to Ann, who accepted. They exchanged rings and made vows in a church in York in 1834, making them the first recorded same-sex couple to marry in the UK.'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: CardContainer(
                  leftWidget: HighlightCard(
                      heading: 'Travels',
                      subHeading:
                          'Anne Lister was an avid traveller and visited many countries during her lifetime. She visited France, Belgium, and the Netherlands in 1820, and later travelled to Russia, Sweden, and Denmark in 1839. Anne kept detailed accounts of her travels in her diaries, which provide valuable insight into the political and cultural climate of the countries she visited.'),
                  rightWidget: const Icon(Icons.place_outlined,
                      color: AppTheme.primaryBtnBackground, size: 120),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 60),
                child: CardContainer(
                  sideLeft: false,
                  leftWidget: const Icon(Icons.elderly_woman_outlined,
                      color: AppTheme.primaryBtnBackground, size: 120),
                  rightWidget: HighlightCard(
                      heading: 'Death and Legacy',
                      subHeading:
                          'Anne Lister died on September 22, 1840, while on a trip to the country of Georgia. She was buried there, but her body was later exhumed and returned to her family\'s estate in Halifax. Anne Lister\'s diaries are considered a valuable historical document and provide insight into the life of a lesbian woman during the 19th century. In 2011, they were added to UNESCO\'s Memory of the World Register, which recognizes significant documentary heritage. In recent years, Anne Lister\'s life and legacy have gained increased attention, with a BBC drama series called "Gentleman Jack" airing in 2019. The series depicts Anne\'s life and relationships, and has helped to bring her story to a wider audience.'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60, bottom: 60),
                child: SectionListTile(
                  title: 'Why Not Get a Deeper Insight?',
                  subtitle:
                      'Thanks to the efforts of the Anne Lister Society, Anne Lister\'s diaries have been translated and are available online. Click the button below to learn more about Anne Lister\'s life and legacy.',
                  buttonTitle: 'Take Me There!',
                  onTap: () async {
                    openUrl(
                        'https://wyascatablogue.wordpress.com/exhibitions/anne-lister/anne-lister-reading-annes-diaries/');
                  },
                  backgroundImage: 'assets/images/big-section-bg.png',
                  image: 'assets/images/blue-clay.png',
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
