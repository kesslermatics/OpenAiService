import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openaiservice/model/AppColors.dart';

import '../widgets/BuildInputWidget.dart';

class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
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
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.botBackgroundColor,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            // Expanded(child: _buildList()),
            Visibility(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  BuildInputWidget(),
                  //_buildSubmit,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
