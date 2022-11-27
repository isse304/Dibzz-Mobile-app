import 'package:flutter/material.dart';
import 'package:gui/dibzznotifier.dart';
import 'package:gui/messaging.dart';

class ConversationsWidget extends StatefulWidget {
  const ConversationsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ConversationsWidgetState();
}

class _ConversationsWidgetState extends State<ConversationsWidget>{
  var defaultpage = true;
  var currentChatIndex = 0;

  void goToConversation() {
    setState(() {
      DibzzNotifier().currentPersonBeingMessaged = currentChatIndex;
      defaultpage = false;
    });
  }

  void goToDefaultScreen() {
    setState(() {
      defaultpage = true;
    });
  }

  Widget getWidget() {
    if (defaultpage) {
      return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder( 
            itemCount: DibzzNotifier.usersBeingMessaged.length, 
            itemBuilder: (BuildContext context, int index) { 
              currentChatIndex = index;
              return ListTile(
                title: Text(DibzzNotifier.usersBeingMessaged[index].otherPerson),
                subtitle: Text(DibzzNotifier.usersBeingMessaged[index].lastMessage()),
                //leading: , //maybe add a profile picture
                onTap: goToConversation,
                ); 
            },)
          );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(DibzzNotifier().getConversation().otherPerson),
          actions: [
            Flexible(child: ElevatedButton(
              onPressed: goToDefaultScreen,
              child: const Text("Go Back"),
            ))
          ],
        ),
        body: const Messaging(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}