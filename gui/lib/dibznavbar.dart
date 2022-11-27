import 'package:flutter/material.dart';
import 'package:gui/Fliter/filter.dart';
import 'package:gui/Settings/settings.dart';
import 'package:gui/addDibzzItem.dart';
import 'package:gui/conversations_widget.dart';
import 'package:gui/dibzznotifier.dart';
import 'package:provider/provider.dart';
import 'map_widget.dart';

class DibzNavBar extends StatefulWidget {
  const DibzNavBar({
    super.key,
  });

  @override
  State<DibzNavBar> createState() => _DibzNavBarState();
}

class _DibzNavBarState extends State<DibzNavBar> {
  var index = 0;
  void _setIndex(int set) {
    setState(() {
      index = set;
    });
  }

  Widget getWidget() {
    switch (index) {
      case 0:
        return const MapWidget();
      case 1:
        return FilterPage();
      case 2:
        return const AddDibzzItem();
      case 3:
        return const ConversationsWidget();
      case 4:
        return const SettingsWidget();
      default:
    }
    return Text("$index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Consumer<DibzzNotifier>(
          builder: (context, value, child) {
            return DefaultTabController(
              length: 5,
              child: Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                      currentIndex: index,
                      showUnselectedLabels: true, // well, that's a surprise!
                      selectedItemColor: Colors.green,
                      unselectedItemColor: Colors.blueAccent,
                      backgroundColor: Colors.blue[200],
                      onTap: _setIndex,
                      items: const [
                        BottomNavigationBarItem(
                            label: 'Map', icon: Icon(Icons.map)),
                        BottomNavigationBarItem(
                            label: 'List', icon: Icon(Icons.article)),
                        BottomNavigationBarItem(
                            label: 'Add', icon: Icon(Icons.add)),
                        BottomNavigationBarItem(
                            label: 'Chat', icon: Icon(Icons.chat)),
                        BottomNavigationBarItem(
                            label: 'Settings', icon: Icon(Icons.settings)),
                      ]),
                  body: getWidget()),
            );
          },
        ));
  }
}
