// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gui/conversation.dart';
import 'package:gui/dibzznotifier.dart';
import 'package:intl/intl.dart';

import 'Message.dart';
import 'package:grouped_list/grouped_list.dart';

class Messaging extends StatefulWidget {
  const Messaging({super.key});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  Conversation conversation = Conversation("otherPerson");

  List<Message> messages = [];
  List<Message> oldmessages = [
    Message(
      text: "Yaaaassssss for sure!",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSentByMe: true,
    ),
    Message(
      text: "No, but I will be available at 4. That work?",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSentByMe: false,
    ),
    Message(
      text: "Sure are you available at 3pm?",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSentByMe: true,
    ),
    Message(
      text: "Hi I want to pick this up",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSentByMe: false,
    ),
  ].reversed.toList();

  void initialize() {
    setState(() {
      conversation = DibzzNotifier().getConversation();
      messages = oldmessages;
    });
  }

  void initialize2() {
    conversation = DibzzNotifier().getConversation();
    messages = conversation.getMessages().cast<Message>();
  }

  @override
  Widget build(BuildContext context) {
    initialize(); //This should pull all the messages in it
    return Column(children: [
      Expanded(
        child: GroupedListView<Message, DateTime>(
          padding: const EdgeInsets.all(8),
          reverse: true,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          floatingHeader: true,
          elements: messages,
          groupBy: (message) => DateTime(
            message.date.year,
            message.date.month,
            message.date.day,
          ),
          groupHeaderBuilder: (Message message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )),
          itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text),
                ),
              )),
        ),
      ),
      Container(
        color: Colors.grey.shade300,
        child: TextField(
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: "Type message here..."),
          onSubmitted: (text) {
            final message = Message(
                text: text,
                date: DateTime.now(),
                isSentByMe:
                    true); //needs to be changed so they can be updated/sent
            setState(() => messages.add(message));
          },
        ),
      )
    ]);
  }
}
