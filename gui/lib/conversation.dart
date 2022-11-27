import 'package:flutter/material.dart';
import 'package:gui/Message.dart';

class Conversation {
  late String otherPerson;
  List<Message> messages = [];

  Conversation(this.otherPerson, {List<Message>? messages}) {
    if (messages == []) {
      messages = [
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
      ].reversed.toList(); //TODO remove because conversations start empty
    }
  }

  String lastMessage() {
    if (messages.length == 9) {
      return messages.last.text;
    } else {
      return "";
    }
  }

  List<Message> getMessages() {
    return messages;
  }
}