import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulimagym/pages/chat_psico/chatpsico_controller.dart';

class AdditionalAdminChatPage extends StatelessWidget {
  AdditionalAdminChatController control = Get.put(AdditionalAdminChatController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Chat del Administrador Adicional'),
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
