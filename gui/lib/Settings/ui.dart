import 'package:flutter/material.dart';
import 'package:gui/dibzznotifier.dart';
import 'package:provider/provider.dart';

class UISettingsWidget extends StatelessWidget {
  const UISettingsWidget({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DibzzTheme(),
      ],
    );
  }
  
}

class DibzzTheme extends StatefulWidget{
  const DibzzTheme({super.key});

  @override
  State<StatefulWidget> createState() => _DibzzTheme();
}

class _DibzzTheme extends State<DibzzTheme> {
  String currentSelectedTheme = "This wont display";
  List<String> themes = ["Dark", "Light", "Flutter", "GoogleDrawing"];

  String getThemeName() {
    return Provider.of<DibzzNotifier>(context, listen: false).themeName;
  }

  @override
  Widget build(BuildContext context) {
    currentSelectedTheme = getThemeName();//needed to initialize the current theme
    return DropdownButton<String>(
      value: currentSelectedTheme, //the default string that is shown
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          currentSelectedTheme = value!;
          Provider.of<DibzzNotifier>(context, listen: false).setTheme(value);
        });
      },
      items: themes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}