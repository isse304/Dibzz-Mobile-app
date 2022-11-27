import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gui/dibznavbar.dart';
import 'package:gui/not_logged_in.dart';
import 'package:provider/provider.dart';
import 'package:gui/dibzznotifier.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: ((context) => DibzzNotifier()),
    child: Consumer<DibzzNotifier>(
      builder: (context, dn, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: dn.themedata,
        //home: const DibzNavBar(),
        home: const NotLoggedIn()
      )
    ),
    ),
  );
}