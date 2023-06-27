import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'pages/index.dart';
import 'pages/annelister.dart';
import 'pages/events.dart';
import 'pages/eventdetails.dart';
import 'pages/services.dart';
import 'pages/encryptor.dart';
import 'pages/partnerships.dart';
import 'styling/styles.dart';
import 'styling/scrolling.dart';

import 'json.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => MyApp();
}

class MyApp extends State<App> {
  Map<String, Widget Function(BuildContext)> appRoutes = {};

  void addRoutes() {
    appRoutes.addEntries([
      MapEntry(
          '/', (context) => const IndexPage(title: 'Anne Lister Festival')),
      MapEntry('/anneLister', (context) => const AnneListerPage()),
      MapEntry('/events', (context) => const EventsPage()),
      MapEntry(
          '/importantServices', (context) => const ImportantServicesPage()),
      MapEntry('/encryptor', (context) => const EncryptorPage()),
      MapEntry('/partnerships', (context) => const PartnershipsPage())
    ]);

    for (var date in Events().getDates()) {
      appRoutes.addEntries(
          [MapEntry('/$date', (context) => EventDetailsPage(eventDate: date))]);
    }
  }

  @override
  void initState() {
    super.initState();
    addRoutes();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anne Lister Festival',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppTheme.background,
      ),
      initialRoute: '/',
      routes: appRoutes,
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      builder: FlutterSmartDialog.init(),
    );
  }
}
