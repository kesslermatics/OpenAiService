import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openaiservice/model/AppColors.dart';
import 'package:openaiservice/model/Message.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final MessageType messageType;

  const MessageWidget(
      {super.key, required this.text, required this.messageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      color: messageType == MessageType.chatGPT
          ? AppColors.chatGPTBackground
          : AppColors.chatGPTLevitatedField,
      child: Row(
        children: [
          messageType == MessageType.chatGPT
              ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const CircleAvatar(
                    backgroundColor: AppColors.chatGPTBackground,
                    child: Icon(
                      Icons.chat_bubble_outline,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
