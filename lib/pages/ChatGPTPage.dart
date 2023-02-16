import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openaiservice/model/APIKey.dart';
import 'package:openaiservice/model/AppColors.dart';

import '../model/Message.dart';
import '../widgets/MessageWidget.dart';

class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  late bool isLoading;
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  Future<String> generateResponse(String prompt) async {
    final apiKey = APIKey;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey"
      },
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": prompt,
          "temperature": 0,
          "max_tokens": 2000,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
        },
      ),
    );

    Map<String, dynamic> newResponse = jsonDecode(response.body);
    return newResponse["choices"][0]["text"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "ChatGPT",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.chatGPTTextColor,
              ),
            ),
          ),
          backgroundColor: AppColors.chatGPTLevitatedField,
        ),
        backgroundColor: AppColors.chatGPTBackground,
        body: Column(
          children: [
            Expanded(child: ListWidget()),
            Visibility(
              visible: isLoading,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InputWidget(),
                  SubmitWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView ListWidget() {
    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: ((context, index) {
        var message = messages[index];
        return MessageWidget(
          text: message.text,
          messageType: message.messageType,
        );
      }),
    );
  }

  Expanded InputWidget() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: AppColors.chatGPTTextColor,
        ),
        controller: textController,
        decoration: InputDecoration(
          fillColor: AppColors.chatGPTLevitatedField,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget SubmitWidget() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        child: IconButton(
          onPressed: onSubmitPressed,
          icon: Icon(
            Icons.send_rounded,
            color: AppColors.chatGPTTextColor,
          ),
        ),
      ),
    );
  }

  void onSubmitPressed() {
    setState(
      () {
        messages.add(
          Message(text: textController.text, messageType: MessageType.user),
        );
        isLoading = true;
      },
    );
    var input = textController.text;
    textController.clear();
    Future.delayed(Duration(milliseconds: 50)).then((value) => scrollDown());

    generateResponse(input).then((value) {
      setState(() {
        isLoading = false;
        messages.add(
          Message(text: value, messageType: MessageType.chatGPT),
        );
      });
    });

    textController.clear();
    Future.delayed(Duration(milliseconds: 50)).then(
      (value) => scrollDown(),
    );
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
