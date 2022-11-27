import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gui/LoginPage.dart';
import 'package:gui/dibznavbar.dart';
import 'package:provider/provider.dart';

import 'dibzznotifier.dart';

class NotLoggedIn extends StatefulWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  NotLoggedInState createState() => NotLoggedInState();
}

class NotLoggedInState extends State<NotLoggedIn> {
  ThemeData getThemeMode() {
    return Provider.of<DibzzNotifier>(context, listen: false).themedata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if ((snapshot.connectionState == ConnectionState.active) 
              || Provider.of<DibzzNotifier>(context, listen: false).skippedSignIn) {
                
                User? user = snapshot.data;
                if (user != null) {
                  return const DibzNavBar();
                } else {
                  return const LoginPage();
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        );
  }
}

