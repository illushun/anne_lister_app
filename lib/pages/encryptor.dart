import 'package:festival/main.dart';
import 'package:festival/styling/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'dart:convert';
import "dart:math";

import '../styling/appbar.dart';
import '../styling/drawer.dart';
import '../styling/styles.dart';
import '../styling/responsive.dart';
import '../styling/footer.dart';

class EncryptorPage extends StatefulWidget {
  const EncryptorPage({super.key});
  @override
  State<EncryptorPage> createState() => _EncryptorPageState();
}

class _EncryptorPageState extends State<EncryptorPage> {
  late TextEditingController _controller;
  final _random = Random();
  String _availableLetters = "";
  List<String> _letters = [];
  List<String> _wordList = [];
  List<String> _revealedWords = [];
  String _currentWord = "abcdef";
  int _numberOfGuesses = 0;
  int _score = 0;

  String _replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  int _getRandInt(int min, int max) {
    return min + _random.nextInt(max - min);
  }

  Future<void> populateWords() async {
    final String response =
        await rootBundle.loadString('assets/word-list.json');
    final data = await json.decode(response);
    setState(() {
      var words = data["words"];
      for (var word in words) {
        setState(() {
          _wordList.add(word);
        });
      }
    });
  }

  void refresh() {
    setState(() {
      _score = 0;
      _currentWord = "";
      _letters.clear();
    });
  }

  void nextWord() {
    setState(() {
      if (_wordList.isEmpty) {
        populateWords();
      }

      _availableLetters = "";
      _currentWord = _wordList[_random.nextInt(_wordList.length)];
      _numberOfGuesses = _getRandInt(2, _currentWord.length);
      for (var i = 0; i < _currentWord.length; i++) {
        if (!_availableLetters.contains(_currentWord[i])) {
          _availableLetters += _currentWord[i];
        }
      }
      _revealedWords.clear();
      _letters.clear();
    });
  }

  void addLetter(String letter) {
    setState(() {
      _letters.add(letter);
    });
  }

  void guessLetter(String letter) {
    if (_numberOfGuesses <= 0) {
      return;
    }

    for (var i = 0; i < _currentWord.length; i++) {
      if (letter != _currentWord[i]) {
        continue;
      }
      setState(() {
        if (!_revealedWords.contains(letter)) {
          _numberOfGuesses -= 1;
          _revealedWords.add(letter);
        }
      });
    }
  }

  void checkGuess(String guess) {
    setState(() {
      if (guess == _currentWord) {
        if (_numberOfGuesses > 0) {
          _score += _numberOfGuesses;
        } else {
          _score++;
        }
      } else {
        _score = 0;
      }
      nextWord();
    });
  }

  void removeLastLetter() {
    setState(() {
      if (_letters.isNotEmpty) {
        _letters.removeLast();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    refresh();
    populateWords();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  'Encrypted (Score: $_score, Guesses: $_numberOfGuesses)',
                  style: Responsive(minWidth: constraints.maxWidth, items: [
                    TextStyles.mobileSection,
                    TextStyles.tabletSection,
                    TextStyles.tabletSection,
                    TextStyles.desktopSection
                  ]).getCorrectText(),
                ),
              ),
              _currentWord.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          Responsive(
                                  minWidth: constraints.maxWidth,
                                  items: AppTheme.itemPadding)
                              .getPadding(),
                          30,
                          Responsive(
                                  minWidth: constraints.maxWidth,
                                  items: AppTheme.itemPadding)
                              .getPadding(),
                          20),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _currentWord.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: _revealedWords
                                      .contains(_currentWord[index])
                                  ? Text(_currentWord[index].toUpperCase(),
                                      style: Responsive(
                                          minWidth: constraints.maxWidth,
                                          items: [
                                            TextStyles.mobileTitle,
                                            TextStyles.tabletTitle,
                                            TextStyles.tabletTitle,
                                            TextStyles.desktopTitle
                                          ]).getCorrectText())
                                  : SvgPicture.asset(
                                      "assets/images/symbols/${_currentWord[index]}.svg"),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
              Container(
                  margin: EdgeInsets.fromLTRB(
                      Responsive(
                              minWidth: constraints.maxWidth,
                              items: AppTheme.itemPadding)
                          .getPadding(),
                      20,
                      Responsive(
                              minWidth: constraints.maxWidth,
                              items: AppTheme.itemPadding)
                          .getPadding(),
                      10),
                  child: const Divider()),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    Responsive(
                            minWidth: constraints.maxWidth,
                            items: AppTheme.itemPadding)
                        .getPadding(),
                    30,
                    Responsive(
                            minWidth: constraints.maxWidth,
                            items: AppTheme.itemPadding)
                        .getPadding(),
                    0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Guess',
                  ),
                  onSubmitted: (String value) async {
                    var oldScore = _score;
                    var guess = value.toLowerCase().trim();

                    setState(() {
                      if (!_revealedWords.contains(guess)) {
                        _revealedWords.add(guess);
                      }
                    });
                    checkGuess(guess);

                    _score > oldScore
                        ? SmartDialog.showNotify(
                            msg: 'Correct!', notifyType: NotifyType.success)
                        : SmartDialog.showNotify(
                            msg: 'Wrong!', notifyType: NotifyType.error);

                    _controller.clear();

                    SmartDialog.show(
                        alignment: Alignment.bottomCenter,
                        builder: (context) {
                          return Container(
                            height: 100,
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
                                10),
                            decoration: BoxDecoration(
                              color: AppTheme.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                                'Score: $_score | Number of Guesses: $_numberOfGuesses',
                                style: TextStyles.desktopSection),
                          );
                        });
                  },
                ),
              ),
              Padding(
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
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _availableLetters.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 25,
                        width: 150,
                        margin: index == 0
                            ? const EdgeInsets.fromLTRB(0, 20, 10, 30)
                            : index == _availableLetters.length - 1
                                ? const EdgeInsets.fromLTRB(0, 20, 0, 30)
                                : const EdgeInsets.fromLTRB(0, 20, 10, 30),
                        child: ElevatedButton(
                          onPressed: () {
                            guessLetter(_availableLetters[index]);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.background,
                            side: _numberOfGuesses > 0
                                ? _revealedWords
                                        .contains(_availableLetters[index])
                                    ? const BorderSide(
                                        width: 2,
                                        color: Colors.red,
                                      )
                                    : const BorderSide(
                                        width: 2,
                                        color: Colors.green,
                                      )
                                : const BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ),
                          ),
                          child: SvgPicture.asset(
                              "assets/images/symbols/${_availableLetters[index]}.svg",
                              height: 35),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Responsive(minWidth: constraints.maxWidth).isMobile() ||
                      Responsive(minWidth: constraints.maxWidth).isTablet()
                  ? Column(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          margin: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                          child: ElevatedButton(
                            onPressed: () {
                              var oldScore = _score;
                              var guess = _controller.text.toLowerCase().trim();

                              setState(() {
                                if (!_revealedWords.contains(guess)) {
                                  _revealedWords.add(guess);
                                }
                              });
                              checkGuess(guess);

                              _score > oldScore
                                  ? SmartDialog.showNotify(
                                      msg: 'Correct!',
                                      notifyType: NotifyType.success)
                                  : SmartDialog.showNotify(
                                      msg: 'Wrong!',
                                      notifyType: NotifyType.error);

                              _controller.clear();

                              SmartDialog.show(
                                  alignment: Alignment.bottomCenter,
                                  builder: (context) {
                                    return Container(
                                      height: 100,
                                      padding: EdgeInsets.fromLTRB(
                                          Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: AppTheme.itemPadding)
                                              .getPadding(),
                                          20,
                                          Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: AppTheme.itemPadding)
                                              .getPadding(),
                                          10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.background,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                          'Score: $_score | Number of Guesses: $_numberOfGuesses',
                                          style: TextStyles.desktopSection),
                                    );
                                  });
                            },
                            style: ButtonStyles.primary,
                            child: const Text(
                              'Guess',
                              style: TextStyles.primaryBtn,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: ElevatedButton(
                            onPressed: () {
                              _score = 0;
                              nextWord();
                            },
                            style: ButtonStyles.secondary,
                            child: const Text(
                              'New Word',
                              style: TextStyles.primaryBtn,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 60),
                          child: ElevatedButton(
                            onPressed: () {
                              SmartDialog.show(builder: (context) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(
                                      Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: AppTheme.itemPadding)
                                              .getPadding() +
                                          20,
                                      20,
                                      Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: AppTheme.itemPadding)
                                              .getPadding() +
                                          20,
                                      10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.background,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                      physics: const ScrollPhysics(),
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return Column(
                                          children: <Widget>[
                                            Text(
                                              'How to Play',
                                              textAlign: TextAlign.center,
                                              style: Responsive(
                                                  minWidth:
                                                      constraints.maxWidth,
                                                  items: [
                                                    TextStyles.mobileTitle,
                                                    TextStyles.tabletTitle,
                                                    TextStyles.tabletTitle,
                                                    TextStyles.desktopTitle
                                                  ]).getCorrectText(),
                                            ),
                                            CardContainer(
                                                sideLeft: false,
                                                leftWidget: const Center(
                                                    child: Text('1',
                                                        style: TextStyles
                                                            .desktopTitle)),
                                                rightWidget: Image.asset(
                                                    'assets/images/decoder_tutorial/score_guesses_highlight.png')),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 60),
                                              padding: EdgeInsets.fromLTRB(
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  20,
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 30),
                                                    child: const Text(
                                                        'Score: Your score is used to determine how many guesses you have got right in a row. Getting a guess right with 2 or more Guesses left adds the amount that is remaining to your score. Getting a guess wrong means your score gets reset to 0.',
                                                        style: TextStyles
                                                            .desktopTableSubHeading),
                                                  ),
                                                  const Text(
                                                      'Guesses: The amount of guesses indicates how many times you can press the symbols at the bottom to guess a letter. If this number reaches 0, you will no longer be able to reveal any letters.',
                                                      style: TextStyles
                                                          .desktopTableSubHeading)
                                                ],
                                              ),
                                            ),
                                            CardContainer(
                                                sideLeft: false,
                                                leftWidget: const Center(
                                                    child: Text('2',
                                                        style: TextStyles
                                                            .desktopTitle)),
                                                rightWidget: Image.asset(
                                                    'assets/images/decoder_tutorial/encrypted_highlight.png')),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  20,
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 60),
                                              child: const Text(
                                                  'When guessing a new word, it will be encrypted using the code Anne Lister used to use in her diaries. Guessing letters decrypts the text incrementally.',
                                                  style: TextStyles
                                                      .desktopTableSubHeading),
                                            ),
                                            CardContainer(
                                                sideLeft: false,
                                                leftWidget: const Center(
                                                    child: Text('3',
                                                        style: TextStyles
                                                            .desktopTitle)),
                                                rightWidget: Image.asset(
                                                    'assets/images/decoder_tutorial/available_letters_highlight.png')),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  20,
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 60),
                                              child: const Text(
                                                  'When generating a new word to guess, each letter in the word is displayed in the bottom row. Pressing a letter will reveal all instances of that letter in the encrypted text. This will also reduce the amount of guesses you have left by 1 and you will notice that the letter you pressed will have a red outline instead of a green one, indicating that you can no longer press it.',
                                                  style: TextStyles
                                                      .desktopTableSubHeading),
                                            ),
                                            CardContainer(
                                                sideLeft: false,
                                                leftWidget: const Center(
                                                    child: Text('4',
                                                        style: TextStyles
                                                            .desktopTitle)),
                                                rightWidget: Image.asset(
                                                    'assets/images/decoder_tutorial/decrypted_highlight.png')),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  20,
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 60),
                                              child: const Text(
                                                  'Feel confident enough or ran out of guesses? Type the answer you think is right into the textfield and you will be provided with feedback depending on if you got it right or wrong.',
                                                  style: TextStyles
                                                      .desktopTableSubHeading),
                                            ),
                                            CardContainer(
                                                sideLeft: false,
                                                leftWidget: const Center(
                                                    child: Text('5',
                                                        style: TextStyles
                                                            .desktopTitle)),
                                                rightWidget: Image.asset(
                                                    'assets/images/decoder_tutorial/newword_button_highlight.png')),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  20,
                                                  Responsive(
                                                          minWidth: constraints
                                                              .maxWidth,
                                                          items: AppTheme
                                                              .itemPadding)
                                                      .getPadding(),
                                                  10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 60),
                                              child: const Text(
                                                  'The \'New Word\' button will generate a new word for you to guess. This will also reset your score and guesses. So only use it if you are really stuck!',
                                                  style: TextStyles
                                                      .desktopTableSubHeading),
                                            ),
                                          ],
                                        );
                                      })),
                                );
                              });
                            },
                            style: ButtonStyles.secondary,
                            child: const Text(
                              'How to Play',
                              style: TextStyles.primaryBtn,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                          Responsive(
                                  minWidth: constraints.maxWidth,
                                  items: AppTheme.itemPadding)
                              .getPadding(),
                          30,
                          Responsive(
                                  minWidth: constraints.maxWidth,
                                  items: AppTheme.itemPadding)
                              .getPadding(),
                          60),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 60),
                            child: ElevatedButton(
                              onPressed: () {
                                var oldScore = _score;
                                var guess =
                                    _controller.text.toLowerCase().trim();

                                setState(() {
                                  if (!_revealedWords.contains(guess)) {
                                    _revealedWords.add(guess);
                                  }
                                });
                                checkGuess(guess);

                                _score > oldScore
                                    ? SmartDialog.showNotify(
                                        msg: 'Correct!',
                                        notifyType: NotifyType.success)
                                    : SmartDialog.showNotify(
                                        msg: 'Wrong!',
                                        notifyType: NotifyType.error);

                                _controller.clear();

                                SmartDialog.show(
                                    alignment: Alignment.bottomCenter,
                                    builder: (context) {
                                      return Container(
                                        height: 100,
                                        padding: EdgeInsets.fromLTRB(
                                            Responsive(
                                                    minWidth:
                                                        constraints.maxWidth,
                                                    items: AppTheme.itemPadding)
                                                .getPadding(),
                                            20,
                                            Responsive(
                                                    minWidth:
                                                        constraints.maxWidth,
                                                    items: AppTheme.itemPadding)
                                                .getPadding(),
                                            10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.background,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                            'Score: $_score | Number of Guesses: $_numberOfGuesses',
                                            style: TextStyles.desktopSection),
                                      );
                                    });
                              },
                              style: ButtonStyles.primary,
                              child: const Text(
                                'Guess',
                                style: TextStyles.primaryBtn,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 60),
                            child: ElevatedButton(
                              onPressed: () {
                                _score = 0;
                                nextWord();
                              },
                              style: ButtonStyles.secondary,
                              child: const Text(
                                'New Word',
                                style: TextStyles.primaryBtn,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 60),
                            child: ElevatedButton(
                              onPressed: () {
                                SmartDialog.show(builder: (context) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(
                                        Responsive(
                                                    minWidth:
                                                        constraints.maxWidth,
                                                    items: AppTheme.itemPadding)
                                                .getPadding() +
                                            20,
                                        20,
                                        Responsive(
                                                    minWidth:
                                                        constraints.maxWidth,
                                                    items: AppTheme.itemPadding)
                                                .getPadding() +
                                            20,
                                        10),
                                    decoration: BoxDecoration(
                                      color: AppTheme.background,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          return Column(
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 60, top: 60),
                                                child: Text(
                                                  'How to Play',
                                                  textAlign: TextAlign.center,
                                                  style: Responsive(
                                                      minWidth:
                                                          constraints.maxWidth,
                                                      items: [
                                                        TextStyles.mobileTitle,
                                                        TextStyles.tabletTitle,
                                                        TextStyles.tabletTitle,
                                                        TextStyles.desktopTitle
                                                      ]).getCorrectText(),
                                                ),
                                              ),
                                              CardContainer(
                                                  sideLeft: false,
                                                  leftWidget: const Center(
                                                      child: Text('1',
                                                          style: TextStyles
                                                              .desktopTitle)),
                                                  rightWidget: Image.asset(
                                                      'assets/images/decoder_tutorial/score_guesses_highlight.png')),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 60),
                                                padding: EdgeInsets.fromLTRB(
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    20,
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    10),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 30),
                                                      child: const Text(
                                                          'Score: Your score is used to determine how many guesses you have got right in a row. Getting a guess right with 2 or more Guesses left adds the amount that is remaining to your score. Getting a guess wrong means your score gets reset to 0.',
                                                          style: TextStyles
                                                              .desktopTableSubHeading),
                                                    ),
                                                    const Text(
                                                        'Guesses: The amount of guesses indicates how many times you can press the symbols at the bottom to guess a letter. If this number reaches 0, you will no longer be able to reveal any letters.',
                                                        style: TextStyles
                                                            .desktopTableSubHeading)
                                                  ],
                                                ),
                                              ),
                                              CardContainer(
                                                  sideLeft: false,
                                                  leftWidget: const Center(
                                                      child: Text('2',
                                                          style: TextStyles
                                                              .desktopTitle)),
                                                  rightWidget: Image.asset(
                                                      'assets/images/decoder_tutorial/encrypted_highlight.png')),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    20,
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    10),
                                                margin: const EdgeInsets.only(
                                                    bottom: 60),
                                                child: const Text(
                                                    'When guessing a new word, it will be encrypted using the code Anne Lister used to use in her diaries. Guessing letters decrypts the text incrementally.',
                                                    style: TextStyles
                                                        .desktopTableSubHeading),
                                              ),
                                              CardContainer(
                                                  sideLeft: false,
                                                  leftWidget: const Center(
                                                      child: Text('3',
                                                          style: TextStyles
                                                              .desktopTitle)),
                                                  rightWidget: Image.asset(
                                                      'assets/images/decoder_tutorial/available_letters_highlight.png')),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    20,
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    10),
                                                margin: const EdgeInsets.only(
                                                    bottom: 60),
                                                child: const Text(
                                                    'When generating a new word to guess, each letter in the word is displayed in the bottom row. Pressing a letter will reveal all instances of that letter in the encrypted text. This will also reduce the amount of guesses you have left by 1 and you will notice that the letter you pressed will have a red outline instead of a green one, indicating that you can no longer press it.',
                                                    style: TextStyles
                                                        .desktopTableSubHeading),
                                              ),
                                              CardContainer(
                                                  sideLeft: false,
                                                  leftWidget: const Center(
                                                      child: Text('4',
                                                          style: TextStyles
                                                              .desktopTitle)),
                                                  rightWidget: Image.asset(
                                                      'assets/images/decoder_tutorial/decrypted_highlight.png')),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    20,
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    10),
                                                margin: const EdgeInsets.only(
                                                    bottom: 60),
                                                child: const Text(
                                                    'Feel confident enough or ran out of guesses? Type the answer you think is right into the textfield and you will be provided with feedback depending on if you got it right or wrong.',
                                                    style: TextStyles
                                                        .desktopTableSubHeading),
                                              ),
                                              CardContainer(
                                                  sideLeft: false,
                                                  leftWidget: const Center(
                                                      child: Text('5',
                                                          style: TextStyles
                                                              .desktopTitle)),
                                                  rightWidget: Image.asset(
                                                      'assets/images/decoder_tutorial/newword_button_highlight.png')),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    20,
                                                    Responsive(
                                                            minWidth:
                                                                constraints
                                                                    .maxWidth,
                                                            items: AppTheme
                                                                .itemPadding)
                                                        .getPadding(),
                                                    10),
                                                margin: const EdgeInsets.only(
                                                    bottom: 60),
                                                child: const Text(
                                                    'The \'New Word\' button will generate a new word for you to guess. This will also reset your score and guesses. So only use it if you are really stuck!',
                                                    style: TextStyles
                                                        .desktopTableSubHeading),
                                              ),
                                            ],
                                          );
                                        })),
                                  );
                                });
                              },
                              style: ButtonStyles.secondary,
                              child: const Text(
                                'How to Play',
                                style: TextStyles.primaryBtn,
                              ),
                            ),
                          ),
                        ],
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
