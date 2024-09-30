import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/pages/chat_client/chatclient_controller.dart';

class ClientChatPage extends StatelessWidget {
  ClientChatController control = Get.put(ClientChatController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Chat del Cliente'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: _buildBody(context),
      ),
    );
  }
}
