import 'package:flutter/material.dart';
import 'package:gui/conversation.dart';


//should be at the top of the widget tree
//will have 1 child, bottomtabbar
class DibzzNotifier extends ChangeNotifier {
  var themeName = "Dark";//default to dark mode
  var themedata = ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          brightness: Brightness.light,
          backgroundColor: const Color(0xFFE5E5E5),
          dividerColor: Colors.white54,
        );
  var skippedSignIn = false;

  void skipTheSignIn() {
    skippedSignIn = true;
    notifyListeners();
  }

  var currentPersonBeingMessaged = 0;
  static List<Conversation> usersBeingMessaged = [
    Conversation("Joe"),
    Conversation("Marcus"),
    Conversation("Marcus1"),
    Conversation("Marcus2"),
  ];

  var currentCategory = "Tvs";
  List<String> categories = ["Tvs", "Furnature", "Appliances", "Couches"];

  var selectedIndex = 0;

  void setTheme(String value) {
    themeName = value;
    switch (themeName) {
      case "Light":
        themedata = ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          brightness: Brightness.light,
          backgroundColor: const Color(0xFFE5E5E5),
          dividerColor: Colors.white54,
        );
        break;
      case "Dark":
        themedata = ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF212121),
          dividerColor: Colors.black12,
        );
        break;
      case "Flutter":
        //will need custom
        break;
      case "Google Drawing":
        //will need custom
        break;
      default:
    }
    notifyListeners();
  }

  Conversation getConversation() {
    return usersBeingMessaged[currentPersonBeingMessaged];
  }
}