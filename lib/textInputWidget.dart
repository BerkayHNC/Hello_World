import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function(String) callback;
  
  TextInputWidget(this.callback);
  
  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {  
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.message), labelText: "Type a message:", 
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          tooltip: "Post message",
          onPressed: this.click,
          )));
  }
}