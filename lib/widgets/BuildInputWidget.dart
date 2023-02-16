import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openaiservice/model/AppColors.dart';

Expanded BuildInputWidget() {
  TextEditingController textController = TextEditingController();

  return Expanded(
    child: TextField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: Colors.white),
      controller: textController,
      decoration: InputDecoration(
        fillColor: AppColors.botBackgroundColor,
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ),
  );
}
