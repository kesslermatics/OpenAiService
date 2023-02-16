import 'package:flutter/cupertino.dart';

enum MessageType { user, chatGPT }

class Message {
  final String text;
  final MessageType messageType;

  Message({required this.text, required this.messageType});
}
