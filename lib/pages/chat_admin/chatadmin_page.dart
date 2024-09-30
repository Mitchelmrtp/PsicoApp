import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './chatadmin_controller.dart';

class AdminChatPage extends StatelessWidget {
  AdminChatController control = Get.put(AdminChatController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Chat del Administrador'),
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
