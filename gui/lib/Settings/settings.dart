import 'package:flutter/material.dart';
import 'package:gui/Settings/account_management.dart';
import 'package:gui/Settings/privacy.dart';
import 'package:gui/Settings/ui.dart';
import 'package:gui/dibzznotifier.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  var settingsWidgetPageIndex = "default";

  Widget defaultScreenWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Consumer<DibzzNotifier>(
      builder: (context, value, child) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: goToAccountManagementPage, child: const Text("Account Management")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: goToPrivacyPage, child: const Text("Privacy")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: goToUIPage, child: const Text("UI")),
              ),
            ],
          ),
        );
      },
    ));
  }

  void goToAccountManagementPage() {
    setState(() {
      settingsWidgetPageIndex = "Account Management";
    });
  }

  void goToPrivacyPage() {
    setState(() {
      settingsWidgetPageIndex = "Privacy";
    });
  }
  
  void goToUIPage() {
    setState(() {
      settingsWidgetPageIndex = "UI";
    });
  }

  void goToDefaultPage() {
    setState(() {
      settingsWidgetPageIndex = "default";
    });
  }

  Widget getWidget(String pageName) {
    if (pageName == "default") {
      return defaultScreenWidget();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("$pageName Settings"),
          actions: [
              Flexible(
                child: ElevatedButton(
                  onPressed: goToDefaultPage,
                  child: const Text("Go Back"),
                )
              )
            ],
        ),
        body: getSecondPageWidget(pageName)
      );
    }
  }

  Widget getSecondPageWidget(String pageName) {
    switch (pageName) {
      case "Account Management":
        return const AccountManagementPage();
      case "UI":
        return const UISettingsWidget();
      case "Privacy":
        return const PrivacyPage();
      default:
        return const Icon(Icons.chair); //todo remove //needed to compile
    }
  }

  @override
  Widget build(Object context) {
    return getWidget(settingsWidgetPageIndex);
  }
}
