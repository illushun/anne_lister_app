import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'styles.dart';

Drawer getDrawer(context) {
  return Drawer(
    child: ListView(
      children: [
        /*const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Text(
            'Festival App2',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),*/
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading: const Icon(Icons.home, color: AppTheme.primaryBtnBackground),
          title: const Text(
            'Home',
          ),
          onTap: () async {
            Navigator.pushNamed(context, '/');
            SmartDialog.showLoading();
            await Future.delayed(const Duration(seconds: 1));
            SmartDialog.dismiss();
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading:
              const Icon(Icons.person, color: AppTheme.primaryBtnBackground),
          title: const Text('Anne Lister'),
          onTap: () async {
            Navigator.pushNamed(context, '/anneLister');
            SmartDialog.showLoading();
            await Future.delayed(const Duration(seconds: 1));
            SmartDialog.dismiss();
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading:
              const Icon(Icons.security, color: AppTheme.primaryBtnBackground),
          title: const Text('Decryptor'),
          onTap: () async {
            Navigator.pushNamed(context, '/encryptor');
            SmartDialog.showLoading();
            await Future.delayed(const Duration(seconds: 1));
            SmartDialog.dismiss();
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading:
              const Icon(Icons.event, color: AppTheme.primaryBtnBackground),
          title: const Text('Events'),
          onTap: () async {
            Navigator.pushNamed(context, '/events');
            SmartDialog.showLoading();
            await Future.delayed(const Duration(seconds: 1));
            SmartDialog.dismiss();
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading: const Icon(Icons.local_play,
              color: AppTheme.primaryBtnBackground),
          title: const Text('Important Services'),
          onTap: () async {
            Navigator.pushNamed(context, '/importantServices');
            SmartDialog.showLoading();
            await Future.delayed(const Duration(seconds: 1));
            SmartDialog.dismiss();
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading:
              const Icon(Icons.people, color: AppTheme.primaryBtnBackground),
          title: const Text('Partnerships'),
          onTap: () async {
            Navigator.pushNamed(context, '/partnerships');
            SmartDialog.showLoading();
            await Future.delayed(const Duration(seconds: 1));
            SmartDialog.dismiss();
          },
        ),
        const Align(
            alignment: Alignment.bottomCenter,
            child: AboutListTile(
              icon: Icon(Icons.info, color: AppTheme.primaryBtnBackground),
              applicationIcon: Icon(Icons.local_play),
              applicationName: 'Festival App',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2021 Google LLC',
              child: Text('About'),
            )),
      ],
    ),
  );
}
